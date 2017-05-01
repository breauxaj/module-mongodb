# Class: mongodb
#
# This class installs the mongodb package
#
# Parameters:
#
#  ensure: (default latest)
#    Determine the state of the packages
#
# Actions:
#   - Installs the mongodb package
#
# Requires:
#
# Sample Usage:
#
#  For a standard installation, use:
#
#    class { 'mongodb':
#      ensure => 'latest'
#    }
#
#  To remove the installation, use:
#
#    class { 'mongodb':
#      ensure => 'absent'
#    }
#
class mongodb (
  $ensure = $::mongodb::params::mongodb_package_ensure
) inherits ::mongodb::params {
  package { $::mongodb::params::mongodb_package:
    ensure  => $ensure,
  }

  $mongodb_config = hiera('mongodb',{})
  create_resources('mongodb::config',$mongodb_config)

  service { $::mongodb::params::mongodb_service:
    ensure  => running,
    enable  => true,
    require => Package[$::mongodb::params::mongodb_package],
  }

}
