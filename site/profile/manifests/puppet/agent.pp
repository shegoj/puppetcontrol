class profile::puppet::agent (
  $master = 'puppet',
  $environment = 'production'
) {

  validate_string($master, $environment)

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
}
