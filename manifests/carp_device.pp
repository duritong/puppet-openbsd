define openbsd::carp_device(
  $carp_ipaddress,
  $carp_subnet,
  $carp_broadcast,
  $carp_vhid,
  $carp_password,
  $carp_advbase = '1',
  $carp_advskew = '0',
  $ensure = 'present'
) {
  include openbsd::carp
  openbsd::special_network_device{$name:
    content => "inet ${carp_ipaddress} ${carp_subnet} ${carp_broadcast} vhid ${carp_vhid} pass ${carp_password} advbase ${carp_advbase} advskew ${carp_advskew}",
    ensure => $ensure,
  }
}
