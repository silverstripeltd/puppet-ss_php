class ss_php::repo(
	$http_proxy = nil,
) {
	include apt

	if $http_proxy!=nil {
		$env = [ "http_proxy=$http_proxy", "https_proxy=$http_proxy", ]
	} else {
		$env = []
	}

	$keypath = '/etc/apt/trusted.gpg.d/php.gpg'
	exec { "sury-php-key":
		environment => $env,
		command => "/usr/bin/wget -O $keypath https://packages.sury.org/php/apt.gpg",
		creates => $keypath,
	}

	ensure_packages(['apt-transport-https', 'lsb-release', 'ca-certificates'], {'ensure' => 'present'})

	apt::source { "php":
		location => "https://packages.sury.org/php/",
		release => $::lsbdistcodename,
		repos => "main",
		include_src => false,
		require => [
			Exec["sury-php-key"],
			Package["apt-transport-https", "lsb-release", "ca-certificates"]
		],
	}
}
