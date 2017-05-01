node default {
  include ::mongodb

  case $::operatingsystem {
    'Amazon': {
        Package { allow_virtual => false }
    }
    default: { }
  }

  mongodb::config {
    'bind_ip': value => "${::ipaddress}"
  }

}
