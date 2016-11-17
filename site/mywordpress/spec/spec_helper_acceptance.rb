require 'beaker-rspec'

logger.error("LOADED MYYYYYYYYYY Spec Acceptance Helper")

# Install Puppet on all hosts
install_puppet_on(hosts, options)

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    # Install module to all hosts
    hosts.each do |host|
      puts "now working on #{host}....................................."
      # Install module
      #copy_module_to(host, source: proj_root, module_name: 'mywordpress')
      install_dev_puppet_module_on(host, :source => module_root, :module_name => 'mywordpress',
          :target_module_path => '/etc/puppet/modules')
      # Install dependencies
      on(host, puppet('module', 'install', 'puppetlabs-stdlib'))
      on(host, puppet('module', 'install', 'puppetlabs-ntp'))

      # Add more setup code as needed
    end
  end
end
