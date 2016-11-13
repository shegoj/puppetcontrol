class profile::wordpress::master {
  class { 'wordpress': 
    version => '4.6'
  }
  include '::mysql::server'
  notify {' will install wordpress master' : }
}

