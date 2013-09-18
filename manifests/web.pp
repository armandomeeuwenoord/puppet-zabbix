# == Class: zabbix::web
#
# Installs zabbix-web and provides vhost config for httpd.
#
# RedHat family only!
#
# === Parameters

# [*server_name*]
#
# [*server_aliases*]
# Array of ServerAlias
#
# [*db_type*]
# 'mysql' or 'pgsql' only
#
# === Authors
# Leszek Charkiewicz <leszek@charkiewicz.net>
#
class zabbix::web (
  $server_name = $::fqdn,
  $server_aliases = undef,
  $db_type = 'mysql',
) {

  $package = $db_type ? {
    'mysql' => 'zabbix20-web-mysql',
    'pgsql' => 'zabbix20-web-pgsql',
  }

  package { $package:
    ensure => present,
  }

  file { '/etc/httpd/conf.d/zabbix-vhost.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('zabbix/vhost.conf.erb'),
  }

}
