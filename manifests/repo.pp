class ss_php::repo {
	include apt

	apt::key { "php":
		key => "DF3D585DB8F0EB658690A554AC0E47584A7A714D",
		key_source => "https://packages.sury.org/php/apt.gpg",
	}

	ensure_packages(['apt-transport-https', 'lsb-release', 'ca-certificates'], {'ensure' => 'present'})

	apt::source { "php":
		location => "https://packages.sury.org/php/",
		release => $::lsbdistcodename,
		repos => "main",
		include_src => false,
		require => [
			Apt::Key["php"],
			Package["apt-transport-https", "lsb-release", "ca-certificates"]
		],
	}
}
