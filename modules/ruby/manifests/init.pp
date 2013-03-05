# base ruby setup and gem bundler
class ruby {
  package { ['ruby1.9.1-full', 'rubygems', 'libxslt1-dev', 'libxml2-dev', 'zlib1g-dev', 'libssl-dev', 'libyaml-dev', 'libsqlite3-dev', 'autoconf', 'libc6-dev', 'libncurses5-dev']: ensure => installed }

  ruby::gem { 'bundle':
    package => 'bundle'
  }
}
