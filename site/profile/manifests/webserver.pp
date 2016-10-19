class profile::webserver {
  #include ntp
	nginx::resource::vhost { 'xwebserver.vagrant.vm':
  listen_port => 80,
  proxy       => 'http://localhost:5601',
	}	
}
