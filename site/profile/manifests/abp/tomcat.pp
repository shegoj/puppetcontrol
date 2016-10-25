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
	
	tomcat::install { '/opt/tomcat6':
		source_url		=> 	'http://www-eu.apache.org/dist/tomcat/tomcat-6/v6.0.45/bin/apache-tomcat-6.0.45.tar.gz',
		catalina_base		=>	"$app_base",
		port			=>	"$app_port",		 
		user			=>	"esportz",
		group			=>	"esportz",
	}	
}
	
	
