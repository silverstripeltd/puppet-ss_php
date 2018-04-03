class ss_php(
	$php_version = $::ss_php::params::php_version,
	$dev = $::ss_php::params::dev,
	$apcu = $::ss_php::params::apcu,
	$imagick = $::ss_php::params::imagick,
	$http_proxy = $::ss_php::params::http_proxy,
) inherits ::ss_php::params {
	if $php_version != undef {
		validate_re($php_version, '^[57].[0-9]')
	}

	$globals_php_version = pick($php_version, $::ss_php::params::php_version)
	$globals_cli_inifile = "/etc/php/${globals_php_version}/cli/php.ini"

	class { "::ss_php::repo":
		http_proxy => $http_proxy,
	}->
	class { "::ss_php::install":
	}
}
