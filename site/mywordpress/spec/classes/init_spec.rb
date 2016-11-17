require 'spec_helper'
describe 'mywordpress' do
  context 'with default values for all parameters' do
    it { should compile }
    it { should contain_class('mywordpress') }
  end

  context 'On Redhat/CenOS 7.0 ' do
    let :params do
      {
        wordpress_version: 'latest',
        apache_version: 'latest',
        wordpress_directory: '/opt'
      }
    end

     it { should contain_package('httpd').with_ensure ('latest') }
     it { 
        should  contain_exec('install wordpress')
         .with_require([ 'Package[httpd]', 'File[wordpress_directory]' ])
         .with_notify ('Service[httpd]') 
       }

  end
end
