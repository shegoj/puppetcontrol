# Class: home_base
# ===========================
#
# Full description of class home_base here.
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
#  External Node Classifier as a comma separated list of hostbaseusers." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'home_base':
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
# Copyright 2016 Your baseuser here, unless otherwise noted.
#
class home_base () inherits home_base::params {
  file {"/home/${baseuser}" :
    ensure  =>  directory,
    mode    =>  '0644',
    owner   =>  'operator',
    group   =>  'operator',
    require =>  User["${baseuser}"],
  }
  user { "${baseuser}" :
    ensure     =>   present,
    password   =>   '$6$xSKTTVSC$WOpe8qFqax4KKlfP.CEE./295h1yFmadpEi7hyp7pLuqQgkLszkKdKCj7DloNIte443BsjaMMNg4Jb3ttAvbI0',
    managehome =>   true,
    home       =>   "/home/${baseuser}",
    gid        =>   '1010',
    groups     =>   'operator',
    require    =>   Group["${baseuser}"],
    shell      =>   '/bin/sh'
  }

  group {"${baseuser}" :
    ensure =>   present,
    gid    =>   '1010',
  }
 
  file { "/etc/sudoers.d/${baseuser}" :
    ensure  =>  present,
    content =>  template ('home_base/sudoers/baseuser.erb'),
    mode    =>  '0644',
    owner   =>  'root',
    group   =>  'root',
    require => User["${baseuser}"],
  }

  ## zabbix agent install
  #
  class { 'zabbix::agent':
    server => "${zabbixserver}",
  }
  
#augeas { "sudo_operator":
#    context => "/files/etc/sudoers",
#    onlyif  => "match spec[user ='operator']/host_group size==0",
#    changes => [
#        "set spec[user = 'operator']/user operator",
#        "set spec[user = 'operator']/host_group/host ALL",
#        "set spec[user = 'operator']/host_group/command ALL",
#       "set spec[user = 'operator']/host_group/command/runas_user root",
#        "set spec[user = 'operator']/host_group/command/tag NOPASSWD",
#    ],
#}
}


