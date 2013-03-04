# Install and configure an nginx server
# including an htpasswd file for basic authentication
class nginx {
  exec { '/usr/bin/add-apt-repository -y ppa:nginx/stable':
    notify => Exec['apt-update'],
    unless => '/usr/bin/test -f /etc/apt/sources.list.d/nginx-stable-quantal.list'
  }

  package { 'nginx-light':
    ensure  => latest,
    require => Exec['/usr/bin/add-apt-repository -y ppa:nginx/stable'],
  }

  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => [File['nginx.conf'], Exec['make-ssl-cert']],
  }

  file { 'default-site':
    ensure  => file,
    path    => '/etc/nginx/sites-available/default',
    require => Package['nginx-light'],
    notify  => Service['nginx'],
    content => template('nginx/default-site.erb'),
  }

  file { 'nginx.conf':
    ensure  => file,
    path    => '/etc/nginx/nginx.conf',
    require => [Package['nginx-light'], File['htpasswd']],
    notify  => Service['nginx'],
    content => template('nginx/nginx.conf.erb'),
  }

  file { 'htpasswd':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    path    => '/etc/nginx/passwd/.htpasswd',
    require => [Package['nginx-light'], File['passwd']],
    source  => 'puppet:///modules/nginx/htpasswd'
  }

  file { 'passwd':
    ensure  => directory,
    path    => '/etc/nginx/passwd',
    require => Package['nginx-light']
  }
}