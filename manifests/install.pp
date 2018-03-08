class php::install inherits ::php {
	php::package { "cli":
		ensure => present,
	}
	alternatives { "php":
		path => "/usr/bin/php${globals_php_version}",
		require => Php::Package["cli"],
	}

	case $dev {
		true: {
			php::package { "dev":
				ensure => present,
			}
			alternatives { "php-config":
				path => "/usr/bin/php-config${globals_php_version}",
				require => Php::Package["dev"],
			}
			alternatives { "phpize":
				path => "/usr/bin/phpize${globals_php_version}",
				require => Php::Package["dev"],
			}
		}
		false: { php::package { "dev": ensure => absent; } }
	}
	case $apcu {
		true: { package { "php-apcu": ensure => present; } }
		false: { package { "php-apcu": ensure => absent; } }
	}
	case $imagick {
		true: { package { "php-imagick": ensure => present; } }
		false: { package { "php-imagick": ensure => absent; } }
	}
}
