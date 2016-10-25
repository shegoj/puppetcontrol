class profile::abpapp::abpbase  {

	class {'java':
		distribution	=>	"jdk",
		#version		=>	"1.7",
		package		=>	"java-1.7.0-openjdk-devel",
	} 
	user { 'esportz':
		ensure 		=> 	present,
		home		=> 	'/home/esportz',
		shell		=> 	'/bin/bash',
		gid 		=>	'wheel',
		password 	=> 	'$6$xSKTTVSC$WOpe8qFqax4KKlfP.CEE./295h1yFmadpEi7hyp7pLuqQgkLszkKdKCj7DloNIte443BsjaMMNg4Jb3ttAvbI0',
		managehome	=>	true
	}
	class {'apache':
	}
	apache::vhost { 'user.example.com':
  		port          => '8080',
  		docroot       => '/var/www/user',
  		docroot_owner => 'www-data',
  		docroot_group => 'www-data',
	}
} 
