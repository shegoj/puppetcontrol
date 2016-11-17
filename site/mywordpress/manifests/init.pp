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
class mywordpress (
  $wordpress_version      =  $::mywordpress::params::wordpress_version,
  $apache_version         =  $::mywordpress::params::apache_version,
  $wordpress_directory    =  $::mywordpress::params::install_directory,
  $wordpress_user         =  $::mywordpress::params::wordpress_user,
) inherits mywordpress::params {

  package{'httpd' :
    ensure => "${apache_version}",
  }

  service{'httpd' :
    ensure => running,
    enable => true,
  }

  file {'wordpress_directory' :
    ensure => directory,
    path   => "${wordpress_directory}"
  }

  user {'wordpress' :
    ensure  => present,
  }

  exec {'install wordpress' :
    command => "wget https://wordpress.org/${wordpress_version}.tar.gz  && tar xvfz ${wordpress_version}.tar.gz -C ${wordpress_directory}",
    path    => '/usr/bin:/usr/sbin:/bin',
    #onlyif  => "test -d ${wordpress_directory}, test -d /var/www/html",
    require => [ Package['httpd'], File['wordpress_directory'] ],
    notify  => Service['httpd'],
  }
}
