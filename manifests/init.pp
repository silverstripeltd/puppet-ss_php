class ss_php(
  Optional[Pattern[/^[57].[0-9]/]] $php_version = $::ss_php::params::php_version,
  $dev = $::ss_php::params::dev,
) inherits ::ss_php::params {
  $globals_php_version = pick($php_version, $::ss_php::params::php_version)
  $globals_cli_inifile = "/etc/php/${globals_php_version}/cli/php.ini"

  class { '::ss_php::repo':
  }
  -> class { '::ss_php::install':
  }
}
