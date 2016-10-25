class abp::params {
	$_install_app_name	=	"abp"
	$_install_dir		=	"/sites/deploy_$_install_app_name"
	notify {"install diretcory is $_install_dir":}
	case $::osfamily {
		'RedHat': {
			notify {" this is $::osfamily $::operatingsystem ":}
			$_version = "10"
			$_deploy_dir = "/sites/whatsup"
		}	
	}
	#### do some checks
	$abp_installs = {
		'version'	=>	$_version,
		'deploy_dir'	=>	$_deploy_dir,
	}	

	
}
