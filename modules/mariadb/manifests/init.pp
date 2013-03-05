# substitute mysql with mariadb by importing signing key and importing repos
class mariadb {

  file { '/etc/apt/sources.list.d/mariadb.list':
    ensure  => file,
    content => 'puppet:///files/mariadb.list',
    notify  => Exec['apt-key mariadb'],
  }

  exec { 'apt-key mariadb':
    refreshonly => true,
    command     => '/usr/bin/apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db',
    notify      => Exec['apt-update'],
  }

  package { 'mariadb-server':
    ensure => present,
    requires => File['/etc/apt/sources.list.d/mariadb.list'],
  }

  package { 'libmysqlclient-dev':
    ensure => present,
    requires => Package['mariadb-server'],
  }

  service { 'mysql':
    ensure => running,
    requires => Package['mariadb-server'],
  }
}