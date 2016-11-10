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
#  External Node Classifier as a comma separated list of hostnames." (Note,
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
# Copyright 2016 Your name here, unless otherwise noted.
#
class home_base {
  user {'operator' :
    ensure     =>   present,
    password    =>   '$6$xSKTTVSC$WOpe8qFqax4KKlfP.CEE./295h1yFmadpEi7hyp7pLuqQgkLszkKdKCj7DloNIte443BsjaMMNg4Jb3ttAvbI0:16791',
    managehome =>   true,
    home       =>   '/home/operator',
    gid        =>   '1010',
    groups      =>   'operator',
    require    =>   Group['operator'],
  }

  group {'operator' :
    ensure =>   present,
    gid    =>   '1010',
  }
  augeas { 'operator' :
    context   =>  '/files/etc/sudoers/',
    onlyif    => "/files/etc/sudoers/spec[user ='operator']/host_group size==0",
    changes   =>  [
      "set spec[01]/user operator",
      "set spec[01]/host_group/host ALL",
      "set spec[01]/host_group/host/command ALL",
      "set spec[01]/host_group/host/command/runas_user ALL",
      "set spec[01]/host_group/host/command/tag NOPASSWD",
    ]
  }
}


