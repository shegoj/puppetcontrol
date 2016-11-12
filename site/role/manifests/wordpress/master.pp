class role::wordpress::master {
  include profile::puppet::agent
  include profile::wordpress::master
}
