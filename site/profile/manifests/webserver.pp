class profile::webserver {
  #include ntp
	class { 'nginx': }

	nginx::resource::vhost { 'xwebserver.vagrant.vm':
  listen_port => 80,
  proxy       => 'http://localhost:5601',
	}	
}
