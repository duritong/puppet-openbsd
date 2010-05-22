class openbsd::ports::setup {
  exec{"setup_ports_tree":
    command => "cd /tmp; ftp ftp://ftp.openbsd.org/pub/OpenBSD/$operatingsystemrelease/ports.tar.gz; cd /usr; tar xzf /tmp/ports.tar.gz; rm /tmp/ports.tar.gz",
    unless => "test -d /usr/ports",
  }
}
