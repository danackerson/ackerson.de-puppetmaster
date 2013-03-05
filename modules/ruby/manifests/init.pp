# base ruby setup and gem bundler
class ruby {
  package { ['ruby1.9.1-full', 'rubygems', 'libxslt-dev', 'libxml2-dev', 'zlib1g-dev', 'libssl-dev', 'libyaml-dev', 'libsqlite3-dev', 'autoconf', 'libc6-dev', 'ncurses-dev']: ensure => installed }

  ruby::gem { 'bundle':
    package => 'bundle'
  }
}
