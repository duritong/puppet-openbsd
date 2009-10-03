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
