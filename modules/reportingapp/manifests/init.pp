# git clone the reporting,connect & exchange apps and
# setup the necessary cronjobs/scripts for daily data import
class reportingapp {
  file { '/root/dev':
    ensure => directory
  }

  exec { 'git clone reporting':
    cwd     => '/root/dev',
    command => '/usr/bin/git clone git@github.com:NemetschekAllplan/ConnectReporting.git reporting',
    unless  => '/usr/bin/test -d /root/dev/reporting/.git',
    require => File['/root/dev', '/root/.ssh/known_hosts'],
  }

  exec { 'git clone exchange':
    cwd     => '/root/dev',
    command => '/usr/bin/git clone git@github.com:NemetschekAllplan/Exchange.git exchange',
    unless  => '/usr/bin/test -d /root/dev/exchange/.git',
    require => File['/root/dev', '/root/.ssh/known_hosts'],
  }

  exec { 'git clone connect':
    cwd     => '/root/dev',
    command => '/usr/bin/git clone git@github.com:NemetschekAllplan/Connect.git connect',
    unless  => '/usr/bin/test -d /root/dev/connect/.git',
    require => File['/root/dev', '/root/.ssh/known_hosts'],
  }

  ruby::gem { 'puma':
    package => 'puma',
  }

  exec { 'bundle install reportingapp':
    cwd     => $::reporting_app_path,
    command => '/usr/local/bin/bundle install --binstubs',
    unless  => "/usr/bin/test -f ${::reporting_app_path}/bin/slimrb",
    require =>[ Exec['git clone reporting'], Ruby::Gem['bundle'], Package['mariadb-server'] ],
  }
}