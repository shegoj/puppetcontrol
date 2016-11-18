# Class: mywordpress
# ===========================
#
# Full description of class mywordpress here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'mywordpress':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class mywordpress::params (
  $wordpress_version = 'latest',
  $apache_version    = 'latest',
  $install_directory = '/opt/',
  $wordpress_user    = 'wordpress',
  $wordpress_group   = 'wordpress',
  $local_db_install  = true,
)
{
  $wp_dependencies =  ['php5', 'libapache2-mod-php5', 'php5-mcrypt', 'php5-mysqlnd-ms','wget']
  $apache_binary = $::osfamily ? {
    'Debian'  => 'apache2',
    'RedHat'  => 'httpd',
    default   => 'httpd',
  }
  notify {'welcome home params':}
}
