class profile::abp::base  {

	class {'java':
		distribution	=>	"jdk",
		#version		=>	"1.7",
		package		=>	"java-1.7.0-openjdk-devel",
	} -> 
	group {'esportz' :
		ensure 		=> 	present,
		gid		=>	5000,
	} ->
	file_line { 'sudo_rule_nopw':
 		 path => '/etc/sudoers',
  		line => '%esportz ALL=(ALL) NOPASSWD: ALL',
	} ->	
	user { 'esportz':
		ensure 		=> 	present,
		home		=> 	'/home/esportz',
		shell		=> 	'/bin/bash',
		gid 		=>	'esportz',
		password 	=> 	'$6$xSKTTVSC$WOpe8qFqax4KKlfP.CEE./295h1yFmadpEi7hyp7pLuqQgkLszkKdKCj7DloNIte443BsjaMMNg4Jb3ttAvbI0',
		managehome	=>	true
	} ->
	class {'apache':
	} ->
	apache::vhost { 'user.example.com':
  		port          => '80',
  		docroot       => '/var/www/user',
  		docroot_owner => 'esportz',
  		docroot_group => 'esportz',
	}
} 
