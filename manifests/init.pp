class ss_php(
  $php_version = $::ss_php::params::php_version,
  $dev = $::ss_php::params::dev,
  $apcu = $::ss_php::params::apcu,
  $imagick = $::ss_php::params::imagick,
) inherits ::ss_php::params {
  if $php_version != undef {
    validate_re($php_version, '^[57].[0-9]')
  }

  $globals_php_version = pick($php_version, $::ss_php::params::php_version)
  $globals_cli_inifile = "/etc/php/${globals_php_version}/cli/php.ini"

  class { '::ss_php::repo':
  }
  -> class { '::ss_php::install':
  }
}
