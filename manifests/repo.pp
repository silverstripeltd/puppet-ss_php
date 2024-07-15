class ss_php::repo {
  include apt

  apt::key { 'php':
    id      => '15058500A0235D97F5D10063B188E2B695BD4743',
    content => file('ss_php/sury-apt-php.gpg'),
  }

  ensure_packages(['apt-transport-https', 'lsb-release', 'ca-certificates'], {'ensure' => 'present'})

  if ($os::name == 'Ubuntu') {
    apt::ppa { 'ppa:ondrej/php': }
  } elsif $os::name == 'Debian' {
    apt::source { 'php':
      location => $ss_php::params::debian_repo_location,
      release  => $os::distro::codename,
      repos    => 'main',
      notify   => Exec['ss_php_repo_force_update'],
      include  => {
        src => false,
      },
      require  => [
        Apt::Key['php'],
        Package['apt-transport-https', 'lsb-release', 'ca-certificates']
      ],
    }
  } else {
    fail('Unsupported operating system for PHP')
  }

  exec { 'ss_php_repo_force_update':
    command     => "/bin/echo 'Apt update after adding sury repo'",
    refreshonly => true,
    logoutput   => true,
    subscribe   => Exec['apt_update'],
  }
}
