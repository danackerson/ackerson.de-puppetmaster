# base environment class to install most common enhancers,
# setup vi as default editor, etc.
class setenv {

  $enhancers = [  'sudo', 'htop', 'unzip', 'git-core', 'ssl-cert',
                  'vim', 'fail2ban', 'build-essential' ]
  package { $enhancers: ensure => 'installed' }

  exec { '/usr/sbin/update-alternatives --set editor /usr/bin/vim.basic':
    unless => '/usr/bin/test /etc/alternatives/editor -ef /usr/bin/vim.basic'
  }

  file { '/etc/environment':
    ensure  => present,
    content => template('setenv/etc/environment.erb'),
  }

}