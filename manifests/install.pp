class ss_php::install inherits ::ss_php {
  ss_php::package { 'cli':
    ensure => present,
  }
  alternatives { 'php':
    path    => "/usr/bin/php${globals_php_version}",
    require => Ss_php::Package['cli'],
  }

  if $dev {
    ss_php::package { 'dev':
      ensure => present,
    }
    alternatives { 'php-config':
      path    => "/usr/bin/php-config${globals_php_version}",
      require => Ss_php::Package['dev'],
    }
    alternatives { 'phpize':
      path    => "/usr/bin/phpize${globals_php_version}",
      require => Ss_php::Package['dev'],
    }
  } else {
    ss_php::package { 'dev':
      ensure => absent,
    }
  }
}
