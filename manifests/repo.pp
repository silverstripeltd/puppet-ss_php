class ss_php::repo {
  include apt

  apt::key { 'php':
    key     => '15058500A0235D97F5D10063B188E2B695BD4743',
    content => file('ss_php/sury-apt-php.gpg'),
  }

  ensure_packages(['apt-transport-https', 'lsb-release', 'ca-certificates'], {'ensure' => 'present'})

  apt::source { 'php':
    location    => 'https://packages.sury.org/php/',
    release     => $::lsbdistcodename,
    repos       => 'main',
    include_src => false,
    notify   => Exec['ss_php_repo_force_update'],
    require     => [
      Apt::Key['php'],
      Package['apt-transport-https', 'lsb-release', 'ca-certificates']
    ],
  }

  exec { 'ss_php_repo_force_update':
      command     => "/bin/echo 'Apt update after adding sury repo'",
      refreshonly => true,
      logoutput   => true,
      subscribe   => Exec['apt_update'],
  }

}
