class profile::zabbix::master {
  include ::home_base

  file {'/tmp/do.txt' :
    ensure  => present,
  }
}
