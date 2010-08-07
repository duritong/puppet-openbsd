class openbsd::ports::setup {
  exec{"setup_ports_tree":
    command => "cd /tmp; ftp ftp://ftp.openbsd.org/pub/OpenBSD/$operatingsystemrelease/ports.tar.gz; cd /usr; tar xzf /tmp/ports.tar.gz; rm /tmp/ports.tar.gz",
    unless => "test -d /usr/ports",
  }

  file{
    '/usr/ports/distfiles':
      ensure => directory,
      require => Exec['setup_ports_tree'],
      owner => root, group => 0, mode => 0644;
    '/usr/ports/distfiles/make_checksums.sh':
      source => "puppet:///modules/openbsd/ports/make_checksums.sh",
      owner => root, group => 0, mode => 0700;
  }
}
