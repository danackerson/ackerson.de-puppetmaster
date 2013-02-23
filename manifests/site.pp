$ntp_server = "0.de.pool.ntp.org 1.de.pool.ntp.org 2.de.pool.ntp.org 3.de.pool.ntp.org"

$apache_php_script_memory = "xyzM"
$apc_php_memory = "123" #MB

$mysql_cache_memory = "abcMB"

$root_mysql_password = "secret"

$report_mysql_db = "abc" #bitnami_wordpress
$report_mysql_user = "123" #bitnami
$report_mysql_pass = "secret"

node default {
  include setenv
  include ntp
}