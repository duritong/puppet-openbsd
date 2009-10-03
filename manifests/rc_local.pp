# use this to add a service to the rc.local
define openbsd::rc_local(
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
