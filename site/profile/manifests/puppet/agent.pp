class profile::puppet::agent (
  $master = 'puppet',
  $environment = 'production'
) {

  notify{"olusegun ${::settings::confdir}":}
  validate_string($master, $environment)
   
  include home_base


  ini_setting { "puppet agent's master":
    ensure => present,
    path => "${::settings::confdir}/puppet.conf",
    section => 'agent',
    setting => 'server',
    value => $master,
  }

  ini_setting { "puppet agent's environment":
    ensure => present,
    path => "${::settings::confdir}/puppet.conf",
    section => 'agent',
    setting => 'environment',
    value => $environment,
  }
  ini_setting { "puppet agent's environment2":
    ensure => present,
    path => "${::settings::confdir}/puppet2.conf",
    section => 'agent',
    setting => 'environment',
    value => $environment,
  }
  ini_setting { "sample setting":
    ensure => present,
    path => "/tmp/foo.ini",
    section => 'bar',
    setting => 'baz',
    value => 'quux',
  }
  file { 'motd':
    name    => '/etc/motd',
    mode    => '0664',
    owner   => 'root',
   	group   => 'root',
    content => ('hello world\n shegoj whats up')
  }
}
