class profile::wordpress::master {
  class { 'wordpress': 
    install_url => 'http://wordpress.org/wordpress-4.6.tar.gz',
  }
  include '::mysql::server'
  notify {' will install wordpress master' : }
}

