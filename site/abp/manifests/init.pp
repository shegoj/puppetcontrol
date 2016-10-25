# Class: abp
# ===========================
#
# Full description of class abp here.
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
#    class { 'abp':
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
class abp(
	$version	=	'latest',
	$abp_app	=	undef
) inherits ::abp::params  {
	
	## perform validation
	#validate_legacy("Optional[String]", "validate_re", "$version", 'present|installed|latest|^[.+_0-9a-zA-Z:~-]+$')
	notify {"well .......................... $version":}
	validate_re($version, 'latest|^[._0-9-]+$', ".....................does not match mate $version")

	case $::osfamily {
		'RedHat': {
			notify {"valid os $::osfamily  $::operatingsystem ":}
			$hola =  $::abp::params::abp_installs['version'] 
		}
		default: {
			 fail("os not valid $::osfamily $::operatingsystem ")
		}
	}

	anchor {'abp::start':} ->
	notify { "begin install $::abp::params::app_name":} ->
	notify { "checking .... $hola ":} ->
	anchor {'::abp::install':} ->
	anchor {'abp::end':} 
}
