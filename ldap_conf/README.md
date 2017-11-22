# docker-ldap-test
admin:cn=admin,dc=coder4,dc=com
secret:admin

ldapadd -h 192.168.99.30 -p 389 -w admin -D "cn=admin,dc=coder4,dc=com" -f ./add_test.ldif

# admin
ldapwhoami -h 192.168.99.30 -p 389 -D "cn=admin,dc=coder4,dc=com" -w admin
# normal user
ldapwhoami -h 192.168.99.30 -p 389 -D "cn=lihy,ou=users,dc=coder4,dc=com" -w pass
