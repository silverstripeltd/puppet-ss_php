define ss_php::package(
  $ensure = 'present',
  $php_version = $::ss_php::globals_php_version
) {
  $php_version_float = Numeric($php_version)
  if $php_version_float >= 7.2 and $name == 'mcrypt' {
    notice('mcrypt is deprecated and unavailable for PHP >= 7.2. Skipping install')
  } else {
    package { "php${php_version}-${name}":
      ensure  => $ensure
    }
  }
}
