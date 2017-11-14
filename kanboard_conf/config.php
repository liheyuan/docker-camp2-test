<?php

//define('DEBUG', true);
//define('LOG_DRIVER', 'file');

define('LDAP_AUTH', true);
define('LDAP_SSL_VERIFY', false);
define('LDAP_START_TLS', false);
define('LDAP_ACCOUNT_CREATION', false);

define('LDAP_SERVER', '192.168.99.30');

define('LDAP_BIND_TYPE', 'proxy');
define('LDAP_USERNAME', 'cn=admin,dc=coder4,dc=com');
define('LDAP_PASSWORD', 'admin');

define('LDAP_USER_BASE_DN', 'ou=users,dc=coder4,dc=com');
define('LDAP_USER_FILTER', 'cn=%s');
define('LDAP_USER_ATTRIBUTE_USERNAME', 'cn');
define('LDAP_USER_ATTRIBUTE_FULLNAME', 'cn');
define('LDAP_USER_ATTRIBUTE_EMAIL', 'mail');

?>

