# Install and configure an nginx server
# including an htpasswd file for basic authentication
class nginx {
  package { 'nginx-light':
    ensure  => latest
  }

  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => File['nginx.conf'],
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
    mode    => '0600',
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