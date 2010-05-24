define openbsd::bridge_device(
    $bridge_interfaces,
    $ensure = 'present'
){
    openbsd::special_network_device{$name:
        content => inline_template("<%= bridge_interfaces.split(',').collect { |bif| \"add #{bif}\" }.join('\n') << \"up\n\""),
        fileprefix => 'bridgename',
        ensure => $ensure;
    }
}
