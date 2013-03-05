# and gem bundler
define ruby::gem($package, $version = "'>= 0'") {
  exec { "gem-install--${package}-${version}":
    require => Package['ruby1.9.1-full', 'rubygems', 'libxslt-dev', 'libxml2-dev', 'zlib1g-dev', 'libssl-dev', 'libyaml-dev', 'libsqlite3-dev', 'autoconf', 'libc6-dev', 'ncurses-dev'],
    command => "/usr/bin/gem install ${package} --version ${version}",
    unless  => "/usr/bin/gem list | /bin/grep ${package}",
  }
}