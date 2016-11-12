class profile::wordpress::master {
  class { 'wordpress': }
  notify {' will install wordpress master' : }
}

