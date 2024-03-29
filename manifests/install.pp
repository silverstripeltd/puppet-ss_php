class ss_php::install inherits ::ss_php {
  if $::ss_php::cli {
    ss_php::package { 'cli':
      ensure => present,
    }
    alternatives { 'php':
      path    => "/usr/bin/php${::ss_php::globals_php_version}",
      require => Ss_php::Package['cli'],
    }
  }

  if $::ss_php::dev {
    ss_php::package { 'dev':
      ensure => present,
    }
    alternatives { 'php-config':
      path    => "/usr/bin/php-config${::ss_php::globals_php_version}",
      require => Ss_php::Package['dev'],
    }
    alternatives { 'phpize':
      path    => "/usr/bin/phpize${::ss_php::globals_php_version}",
      require => Ss_php::Package['dev'],
    }
  } else {
    ss_php::package { 'dev':
      ensure => absent,
    }
  }

  # Remove metapackages we used to install. We just want specific versions.
  package {
    'php-apcu': ensure => absent;
    'php-apcu-bc': ensure  => absent;
    'php-imagick': ensure  => absent;
  } -> Ss_php::Package <| |>
}
