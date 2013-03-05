# base environment class to install most common enhancers,
# setup vi as default editor, etc.
class setenv {
  package { 'sudo':     ensure => installed }
  package { 'rcconf':   ensure => installed }
  package { 'htop':     ensure => installed }
  package { 'unzip':    ensure => installed }
  package { 'vim' :     ensure => installed }
  package { 'git-core': ensure => installed }
  package { 'ssl-cert': ensure => installed }
  package { 'fail2ban': ensure => installed }
  package { 'software-properties-common': ensure => installed }

  package { 'build-essential':
    ensure  => latest,
    require => Exec['apt-update']
  }

  exec { 'apt-update':
    command     => '/usr/bin/apt-get update',
    refreshonly => true
  }

  exec { '/usr/sbin/update-alternatives --set editor /usr/bin/vim.basic':
    unless  => '/usr/bin/test /etc/alternatives/editor -ef /usr/bin/vim.basic',
    require => Package['vim']
  }

  exec { 'make-ssl-cert':
    command => '/usr/bin/make-ssl-cert generate-default-snakeoil --force-overwrite',
    unless  => '/usr/bin/test -f /etc/ssl/private/ssl-cert-snakeoil.key',
    require => Package['ssl-cert']
  }

  file { '/etc/environment':
    ensure  => present,
    content => template('setenv/etc/environment.erb'),
  }

  file { '/root/.ssh':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0600'
  }
  # add github as known host
  file { '/root/.ssh/known_hosts' :
    ensure  => present,
    source  => 'puppet:///modules/setenv/known_hosts',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/root/.ssh'],
  }
}