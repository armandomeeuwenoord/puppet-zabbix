# == Class: zabbix
#
# Parameters userd for for zabbix agent, proxy and server configuration
#
# === Variables
#
# Most of them are named very similiar to variables configuration files.
# Should be obvious enough :)
#
class zabbix::params {
  ### common parameters for all services
  $zabbix_server             = undef# general parameters
  $source_ip                 = undef
  $debug_level               = 3
  $timeout                   = 3
  $listen_ip                 = '0.0.0.0'
  $hostname                  = $::hostname
  $hostname_item             = 'system.hostname'
  $listen_port               = 10051
  $server_db_type            = 'mysql'
  $server_db_host            = 'localhost'
  $server_db_name            = 'zabbix'
  $server_db_user            = 'zabbix'
  $server_db_password        = undef
  $server_db_port            = 3306 # 3306 for mysql, for pgsql
  $server_db_schema          = undef
  $proxy_db_type             = 'sqlite3'
  $proxy_db_host             = 'localhost'
  $proxy_db_name             = 'zabbix'
  $proxy_db_name_sqlite3     = '/var/lib/zabbix/zabbix.db'# TODO check for mysql and pgsql
  $proxy_db_user             = 'zabbix'
  $proxy_db_password         = undef
  $proxy_db_port             = 3306 # 3306 for mysql, for pgsql
  $start_pollers             = 5# advanced parameters
  $start_ipmi_pollers        = 0
  $start_pollers_unreachable = 1
  $start_trappers            = 5
  $start_pingers             = 1
  $start_discoverers         = 1
  $housekeeping_frequency    = 1
  $start_db_syncers          = 4
  $cache_size                = '8M'
  $history_cache_size        = '8M'
  $history_text_cache_size   = '16M'
  $trapper_timeout           = 300
  $unreachable_period        = 45
  $unavailable_delay         = 60
  $unreachable_delay         = 15
  $fping_location            = '/usr/sbin/fping'
  $fping6_location           = '/usr/sbin/fping6'
  $ssh_key_location          = undef
  $log_slow_queries          = 0
  $tmp_dir                   = '/tmp'
  $include                   = undef
  $zabbix_server_active      = undef### agent parameters ###
  $enable_remote_commands    = 0
  $log_remote_commands       = 0
  $agent_listen_port         = 10050
  $refresh_active_checks     = 120
  $buffer_send               = 5
  $buffer_size               = 100
  $max_lines_per_second      = 100
  $allow_root                = 0
  $alias                     = undef
  $start_agents              = 3
  $unsafe_user_parameters    = 0
  $user_parameter            = undef
  $node_id                   = 0### server parameters ###
  $start_http_pollers        = 1
  $max_housekeeper_delete    = 500
  $disable_housekeeping      = 0
  $sender_frequency          = 30
  $cache_update_frequency    = 60
  $node_no_events            = 0
  $node_no_history           = 0
  $start_proxy_pollers       = 1
  $proxy_config_frequency    = 3600
  $proxy_data_frequency      = 1
  $proxy_mode                = 0# proxy parameters
  $server_port               = 10051
  $proxy_local_buffer        = 0
  $proxy_offline_buffer      = 1
  $heartbeat_frequency       = 60
  $config_frequency          = 3600
  $data_sender_frequency     = 1
  $trend_cache_size          = '4M'

  case $::operatingsystem {
    default, /(Ubuntu|Debian)/: {
      $db_socket                    = '/tmp/mysql.sock'
      $agent_package_name            = 'zabbix-agent'
      $agent_service_name            = 'zabbix-agent'
      $agent_config_file             = '/etc/zabbix/zabbix_agent.conf'
      $agent_config_template         = 'zabbix/zabbix_agent.conf.erb'
      $agentd_config_file            = '/etc/zabbix/zabbix_agentd.conf'
      $agentd_config_template        = 'zabbix/zabbix_agentd.conf.erb'
      $agent_pid_file               = '/var/run/zabbix/zabbix_agentd.pid'
      $agent_log_file               = '/var/log/zabbix-agent/zabbix_agentd.log'
      $agent_log_file_size          = 0
      $agent_disable_passive         = 0
      $agent_disable_active          = 0
      $agent_server_port             = 10051
      $agent_include                 = '/etc/zabbix/zabbix_agentd.conf.d/'
      $server_package_name           = 'zabbix-server'# TODO - zabbix-server-{sqlite3,mysql,pgsql}
      $server_service_name           = 'zabbix-server'
      $server_config_file            = '/etc/zabbix/zabbix-server.conf'
      $server_config_template        = 'zabbix/zabbix_server.conf.erb'
      $server_pid_file               = '/var/run/zabbix/zabbix_server.pid'
      $server_log_file               = '/var/log/zabbix-server/zabbix_server.log'
      $server_log_file_size          = 1
      $server_alert_scripts_path     = '/etc/zabbix/alert.d/'
      $proxy_package_name           = 'zabbix-proxy'
      $proxy_service_name           = 'zabbix-proxy'
      $proxy_config_file            = '/etc/zabbix/zabbix-proxy.conf'
      $proxy_config_template        = 'zabbix/zabbix_proxy.conf.erb'
      $proxy_pid_file                = '/var/run/zabbix/zabbix_proxy.pid'
      $proxy_log_file                = '/var/log/zabbix-proxy/zabbix_proxy.log'
      $proxy_log_file_size           = 1
      $proxy_db_name_sqlite3         = '/var/lib/zabbix/zabbix.db'# TODO check for mysql and pgsql
      $external_scripts        = '/etc/zabbix/externalscripts'
      #$proxy_cache_update_frequency = 60
      #$proxy_trend_size_cache       = '4M'
    }

    /(RedHat|CentOS|Fedora)/: {
      # 2.0
      $agent20_package_name        = 'zabbix20-agent'
      $agent20_config_file = '/etc/zabbix_agent.conf'
      $agentd20_config_file = '/etc/zabbix_agentd.conf'
      $proxy20_package_name        = 'zabbix20-proxy'
      $proxy20_config_template  = 'zabbix/zabbix20_proxy.conf.erb'
      $proxy20_config_file = '/etc/zabbix_proxy.conf'
      #$proxy20_external_scripts    = '/etc/zabbix/externalscripts'
      $server20_package_name       = 'zabbix20-server'
      $server20_config_file = '/etc/zabbix_server.conf'
      $server20_config_template = 'zabbix/zabbix20_server.conf.erb'
      $server20_pid_file           = '/var/run/zabbix/zabbix_server.pid'
      $server20_start_snmp_trapper = 0 # proxy takze
      $server20_alert_scripts_path = '/var/lib/zabbixsrv/alertscripts'
      $web20_package_name          = 'zabbix20-web'
      $java_gateway       = undef # proxy takze
      $java_gateway_port  = 10052 # proxy takze
      $start_java_pollers = 0 # proxy takze
      $smtp_trapper_file  = '/tmp/zabbix_traps.tmp' # proxy takze
      $server20_external_scripts   = '/var/lib/zabbixsrv/externalscripts' #TODO add case in config
      # 1.8
      $agent_package_name        = 'zabbix-agent'
      $agent_config_file         = '/etc/zabbix/zabbix_agent.conf'
      $agentd_config_file        = '/etc/zabbix/zabbix_agentd.conf'
      $proxy_package_name        = 'zabbix-proxy'
      $proxy_config_template  = 'zabbix/zabbix_proxy.conf.erb'
      $proxy_config_file      = '/etc/zabbix/zabbix_proxy.conf'
      $server_package_name       = 'zabbix-server'
      $server_pid_file           = '/var/run/zabbix/zabbix.pid'
      $server_alert_scripts_path = '/var/lib/zabbix/'
      $external_scripts  = '/etc/zabbix/externalscripts'
      $web_package_name          = 'zabbix-web'
      # common
      $db_socket              = '/var/lib/mysql/mysql.sock'
      $agent_service_name     = 'zabbix-agent'
      $agent_include_folder   = '/etc/zabbix/zabbix_agentd.conf.d'
      $agent_config_template  = 'zabbix/zabbix_agent.conf.erb'
      $agentd_config_template = 'zabbix/zabbix_agentd.conf.erb'
      $agent_pid_file         = '/var/run/zabbix/zabbix_agentd.pid'
      $agent_log_file         = '/var/log/zabbix/zabbix_agentd.log'
      $agent_log_file_size    = 0
      $agent_include          = '/etc/zabbix/zabbix_agentd.conf.d/'
      $server_service_name    = 'zabbix-server'
      $server_config_file     = '/etc/zabbix/zabbix_server.conf'
      $server_config_template = 'zabbix/zabbix_server.conf.erb'
      $server_log_file        = '/var/log/zabbix/zabbix_server.log'
      $server_log_file_size   = 0
      $proxy_service_name    = 'zabbix-proxy'
      $proxy_pid_file         = '/var/run/zabbix/zabbix_proxy.pid'
      $proxy_log_file         = '/var/log/zabbix/zabbix_proxy.log'
      $proxy_log_file_size    = 0
    }

    /(SLES|OpenSuSE)/: {
      $agent_package_name     = 'zabbix-agent'
      $agent_service_name     = 'zabbix-agentd'
      $agent_config_file      = '/etc/zabbix/zabbix-agent.conf'
      $agent_config_template  = 'zabbix/sles.zabbix-agent.conf.erb'
      $agentd_config_file     = '/etc/zabbix/zabbix-agentd.conf'
      $agentd_config_template = 'zabbix/sles.zabbix-agentd.conf.erb'
      $server_package_name    = 'zabbix-server'
      $server_service_name    = 'zabbix-server'
      $agentd_pid_file        = '/var/run/zabbix/zabbix-agentd.pid'
      $agentd_log_file        = '/var/log/zabbix/zabbix-agentd.log'
      $agentd_log_file_size   = 1
      $agent_include          = '/etc/zabbix/zabbix-agentd.conf.d/'
      # TODO server variables
      # TODO proxy variables
    }

  }

}
