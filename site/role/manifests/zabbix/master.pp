class role::zabbix::master {
  include profile::zabbix::master
  include profile::puppet::agent
}
