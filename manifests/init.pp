class php(
	$php_version = $::php::params::php_version,
	$dev = $::php::params::dev,
	$apcu = $::php::params::apcu,
	$imagick = $::php::params::imagick,
) inherits ::php::params {
	if $php_version != undef {
		validate_re($php_version, '^[57].[0-9]')
	}

	$globals_php_version = pick($php_version, $::php::params::php_version)
	$globals_cli_inifile = "/etc/php/${globals_php_version}/cli/php.ini"
	$globals_apache_inifile = "/etc/php/${globals_php_version}/apache2/php.ini"

	class { "::php::repo":
	}->
	class { "::php::install":
	}
}
