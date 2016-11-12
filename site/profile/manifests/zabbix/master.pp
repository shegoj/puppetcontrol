class profile::zabbix::master inherits profile::zabbix::base {

  class { 'apache':
    mpm_module => 'prefork',
  }
  include apache::mod::php

  class { 'postgresql::server': }

}
