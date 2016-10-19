class profile::webserver {
  #include ntp
	class { 'nginx': }

	nginx::resource::vhost { 'xwebserver.vagrant.vm':
  listen_port => 80,
  proxy       => 'http://localhost:5601',
  proxy_set_header => [
    'Host $host',
    'X-Real-IP $remote_addr',
    'X-Forwarded-For $proxy_add_x_forwarded_for',
    'Proxy ""',
  ],
	
	}	
}
