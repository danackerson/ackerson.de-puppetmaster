# base environment class to install most common enhancers,
# setup vi as default editor, etc.
class setenv {
  package { 'sudo':             ensure => 'installed' }
  package { 'htop':             ensure => 'installed' }
  package { 'unzip':            ensure => 'installed' }
  package { 'vim' :             ensure => 'installed' }
  package { 'git-core':         ensure => 'installed' }
  package { 'ssl-cert':         ensure => 'installed' }
  package { 'fail2ban':         ensure => 'installed' }
  package { 'build-essential':  ensure => 'installed' }

  exec { '/usr/sbin/update-alternatives --set editor /usr/bin/vim.basic':
    unless  => '/usr/bin/test /etc/alternatives/editor -ef /usr/bin/vim.basic',
    require => Package['vim']
  }

  file { '/etc/environment':
    ensure  => present,
    content => template('setenv/etc/environment.erb'),
  }

}