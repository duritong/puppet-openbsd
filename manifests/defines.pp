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
            $pkg_cmd =  "PKG_PATH=ftp://mirror.switch.ch/pub/OpenBSD/$kernelversion/packages/$hardwaremodel/;pkg_add -r ${name}"
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
    $start_cmd = 'absent'
){
    case $start_cmd {
        'absent': { $real_start_cmd = $binary }
        default: { $real_start_cmd = $start_cmd }
    }
    exec{"enable_${name}_on_boot":
        command => "echo 'if [ -x ${binary} ]; then echo -n \" ${name}\"; ${real_start_cmd}; fi' >> /etc/rc.local",
        unless => "grep -q \"${name}\" /etc/rc.local",
    }
}
