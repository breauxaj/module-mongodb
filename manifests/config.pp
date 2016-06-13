define mongodb::config (
  $value
) {
  include ::mongodb

  $key = $title

  augeas { "mongodb_conf/${key}":
    context => $::mongodb::params::mongodb_context,
    onlyif  => "get ${key} != '${value}'",
    changes => "set ${key} '${value}'",
    require => Package[$::mongodb::params::mongodb_package],
    notify  => Service[$::mongodb::params::mongodb_service],
  }
}
