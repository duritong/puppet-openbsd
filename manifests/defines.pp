# manifests/defines.pp

# use this only if you have to install a special package
# as the package provider isn't yet that comfortable on
# openbsd
define openbsd::special_package(
    $ensure = 'present',
    $check_str = 'absent'
){
    case $check_str {
        'absent': { $real_check_str = $name }
        default: { $real_check_str = $check_str }
    }


    case $ensure {
        'absent': {
            $pkg_cmd = "pkg_delete ${name}"
            $pkg_check_cmd = "pkg_info | grep -q ${real_check_str}; test $? -gt 0"  
        }
        default: {
            $pkg_cmd =  "PKG_PATH=ftp://mirror.switch.ch/pub/OpenBSD/${operatingsystemrelease}/packages/${hardwaremodel}/;pkg_add -r ${name}"
            $pkg_check_cmd = "pkg_info | grep -q ${real_check_str}"               
        }
    }

    exec{"openbsd_package_${name}":
        command => $pkg_cmd,
        unless => $pkg_check_cmd,
        path => '/bin:/sbin:/usr/bin:/usr/sbin',
    }
}

# use this to add a service to the rc.local
define openbsd::add_to_rc_local(
    $binary,
    $test_op = '-x',
    $start_cmd = 'absent',
    $ensure = 'present'
){
    case $start_cmd {
        'absent': { $real_start_cmd = $binary }
        default: { $real_start_cmd = $start_cmd }
    }
    line { "enable_${name}_on_boot":
        file => "/etc/rc.local",
        line => "if [ ${test_op} ${binary} ]; then echo -n \" ${name}\"; ${real_start_cmd}; fi",
        ensure => $ensure,
    }
}

define openbsd::add_carp_device(
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
    include openbsd::network
    file{"/etc/hostname.${name}":
        content => "inet ${carp_ipaddress} ${carp_subnet} ${carp_broadcast} vhid ${carp_vhid} pass ${carp_password} advbase ${carp_advbase} advskew ${carp_advskew}",
        notify => Exec['restart_network'],
        ensure => $ensure,
        owner => root, group => 0, mode => 0600; 
    }
}
