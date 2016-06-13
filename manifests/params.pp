# Class: mongodb::params
#
# This class set parameters used in this module
#
# Actions:
#   - Defines numerous parameters used by other classes
#
class mongodb::params {
  $mongodb_package_ensure = 'latest'
  
  case $::operatingsystem {
    'CentOS', 'Debian', 'OracleLinux', 'RedHat': {
      $mongodb_config  = '/etc/mongodb.conf'
      $mongodb_package = 'mongodb-server'
      $mongodb_service = 'mongodb'
    
      group { 'mongodb':
        ensure => present,
        gid    => 184,
      }
    
      user { 'mongodb':
        ensure     => present,
        gid        => 184,
        home       => '/var/lib/mongodb',
        shell      => '/bin/false',
        managehome => true,
        uid        => 184,
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::operatingsystem} based system.")
    }
  }
}