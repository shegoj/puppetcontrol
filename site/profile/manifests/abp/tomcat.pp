class profile::abp::tomcat (
	$port	=	undef,
	$base	=	undef,
) inherits profile::abp::base {
	if $port == undef   {
		$app_port = 8089
		notify { "now setting app port":}
	 }
	else {$app_port = $port }

	if $base == undef  {
		$app_base = "/home/esportz/tomcatapp"
		notify { "now setting app base":}
	 }
	else {$app_base = $base }

	file {'remove-dir':
		ensure	=>	absent,
		path	=>	'/opt/tomcatapp/abp',
		recurse	=>	true,
		purge	=>	true,
		force	=>	true,
	}
	
	tomcat::install {"$app_base":
		source_url		=> 	'http://www-eu.apache.org/dist/tomcat/tomcat-6/v6.0.47/bin/apache-tomcat-6.0.47.tar.gz',
                #user                    =>      "esportz",
                #group                   =>      "esportz",
	}
	tomcat::instance { 'tomcat-abp':
		catalina_home		=>	"$app_base",
		catalina_base		=>	"$app_base",
		#user			=>	"esportz",
		#group			=>	"esportz",
		java_home		=>	"/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.111-2.6.7.2.el7_2.x86_64"
	}	
        tomcat::setenv::entry {'CATALINA_OPTS':
                value           =>      "'-Xmx1024m -Duser.language=en -Duser.country=GB -Dsettings.override.file=/vagrant/file.csv  -Dstatus.socket.port=3309 -Djava.awt.headless=true -Ddeployment=Argus.cct.dev.sports-backend-argus-1 -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -DbaseSpoke=cct_dev -Djava.security.egd=file:///dev/urandom'",
                catalina_home   =>      "$app_base",
        }
	tomcat::config::server { 'tomcat6-server':
		catalina_base		=>	"$app_base",
		port			=>	'8105',
	}

	tomcat::config::server::connector { 'tomcat6-config':
		catalina_base		=>	"$app_base",
		port			=>	'19090',		 
		protocol              => 'HTTP/1.1',
  		additional_attributes => {
    			'redirectPort' => '18443'
  		},
	}
	
	tomcat::war { 'argus.war':
  		catalina_base => "$app_base",
  		war_source    => '/vagrant/argus.war',
	}
	tomcat::service { 'tomcat':
                catalina_home           =>      "$app_base",
                catalina_base           =>      "$app_base",
		#use_init		=>	true,
		service_name		=> 	"tomcat",
		start_command		=>	"$app_base/bin/catalina.sh start",
		stop_command		=>	"$app_base/bin/catalina.sh stop",
		java_home               =>      "/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.111-2.6.7.2.el7_2.x86_64"
	}
		
	file_line { "Tomcat Memory":
		line => 'CATALINA_OPTS="-Xmx2048m -Duser.language=en -Duser.country=GB -Dsettings.override.file=/vagrant/file.csv -Ddeployment=Argus.cct.dev.sports-backend-argus-1 -Dplatform.home=/home/esportz/tomcatapp "',
		path=> "/home/esportz/tomcatapp/bin/catalina.sh",
		notify =>Service['tomcat'],
		match => "CATALINA_OPTS=.*",
  	}
	service { "tomcat" :
    		#provider 	=> "init",
		pattern		=> "ps -ef | grep tomcat | grep java | grep -v grep",
    		ensure 		=> stopped,
    		start 		=> "$app_base/bin/startup.sh",
    		stop 		=> "$app_base/bin/shutdown.sh",
    		status 		=> "",
    		restart 	=> "",
    		hasstatus 	=> false,
    		hasrestart 	=> false,
  	}
}
	
	
