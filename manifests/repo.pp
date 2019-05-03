class ss_php::repo {
  include apt

  apt::key { 'php':
    id     => '15058500A0235D97F5D10063B188E2B695BD4743',
    content => file('ss_php/sury-apt-php.gpg'),
  }

  ensure_packages(['apt-transport-https', 'lsb-release', 'ca-certificates'], {'ensure' => 'present'})

  if ($::operatingsystem == 'Ubuntu') {
    apt::ppa { 'ppa:ondrej/php': }
  } elsif $::operatingsystem == 'Debian' {
    apt::source { 'php':
      location    => 'https://packages.sury.org/php/',
      release     => $::lsbdistcodename,
      repos       => 'main',
      include     => {
        src => false
      },
      require     => [
        Apt::Key['php'],
        Package['apt-transport-https', 'lsb-release', 'ca-certificates']
      ],
    }
  } else {
    fail('Unsupported operating system for PHP')
  }
}
