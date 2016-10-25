class profile::abp::tomcat (
	$port	=	undef,
	$base	=	undef,
) inherits profile::abp::base {
	if $port == undef   {
		$app_port = 8080
		notify { "now setting app port":}
	 }
	else {$app_port = $port }

	if $base == undef  {
		$app_base = "/opt/tomcatapp"
		notify { "now setting app base":}
	 }
	else {$app_base = $base }
	
	tomcat::install {"$app_base":
		source_url		=> 	'http://www-eu.apache.org/dist/tomcat/tomcat-6/v6.0.45/bin/apache-tomcat-6.0.45.tar.gz',
	}
	tomcat::instance { 'tomcat6':
		catalina_home		=>	"$app_base",
		catalina_base		=>	"$app_base/abp",
		user			=>	"esportz",
		group			=>	"esportz",
	}	
	tomcat::config::server { 'tomcat6-config':
		catalina_base		=>	"$app_base/abp",
		port			=>	"$app_port",		 
}
	
	
