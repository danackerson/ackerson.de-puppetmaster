# git clone the ConnectReporting app and
# setup the necessary cronjobs/scripts for daily data import
class reporting-app {
  file { '/root/dev':
    ensure => directory
  }

  exec { 'git clone connectreporting':
    cwd     => '/root/dev',
    command => '/usr/bin/git clone git@github.com:NemetschekAllplan/ConnectReporting.git connectreporting',
    unless  => '/usr/bin/test -d /root/dev/connectreporting/.git',
    require => File['/root/dev'],
  }
}