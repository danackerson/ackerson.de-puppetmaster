# get ruby setup and gem bundler
class ruby {
  package { ['ruby1.9.1-full', 'rubygems', 'libxslt1-dev', 'libxml2-dev']: ensure => installed }

  include ruby::gem
  ruby::gem { 'bundle':
    package => 'bundle'
  }
}
