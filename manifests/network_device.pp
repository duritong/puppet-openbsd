define openbsd::network_device(
  $net_ipaddress,
  $net_subnet,
  $net_additional_params = 'NONE',
  $ensure = 'present'
){
  openbsd::special_network_device{$name:
    content => "inet ${net_ipaddress} ${net_subnet} ${net_additional_params}",
    ensure => $ensure;
  }
}
