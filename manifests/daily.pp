# manage the daily.local file
class openbsd::daily {
  file{'/etc/daily.local':
    ensure => present,
    owner  => root,
    group  => 0,
    mode   => '0644';
  }
}
