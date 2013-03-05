# and gem bundler
define ruby::gem($ruby::package, $ruby::version = '>= 0') {
  exec { "gem-install--${ruby::package}-${ruby::version}":
    require => Package['ruby1.9.1-full','rubygems','libxslt1-dev','libxml2-dev'],
    command => "/usr/bin/gem install ${ruby::package} --version ${ruby::version}",
    unless  => "/usr/bin/gem list | /bin/grep ${ruby::package}",
  }
}