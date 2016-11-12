class profile::zabbix::master {
  include ::home_base

  file {'/tmp/do.txt' :
    ensure  => present,
  }
  class { 'apache':
    mpm_module => 'prefork',
  }
  include apache::mod::php

  class { 'postgresql::server': }

  class { 'zabbix':
    zabbix_url    => 'zabbix.example.com',
  }
}
