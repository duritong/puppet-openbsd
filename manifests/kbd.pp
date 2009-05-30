define openbsd::kbd(){
  file{'/etc/kbdtype':
    content => "${name}\n",
    owner => root, group => 0, mode => 0644;
  }
}
