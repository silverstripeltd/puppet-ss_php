define php::config::setting(
	$file,
	$key,
	$value,
) {
	$split_name = split($key, '/')
	if count($split_name) == 1 {
		$section = '' # lint:ignore:empty_string_assignment
		$setting = $split_name[0]
	} else {
		$section = $split_name[0]
		$setting = $split_name[1]
	}

	if $value == undef {
		$ensure = 'absent'
	} else {
		$ensure = 'present'
	}

	ini_setting { $name:
		ensure => $ensure,
		value => $value,
		path => $file,
		section => $section,
		setting => $setting,
	}
}
