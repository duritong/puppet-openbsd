# you can manage the devices with 
# the whole content
# name: device
# content: content of the file
define openbsd::special_network_device(
    $content,
    $fileprefix = 'hostname',
    $ensure = 'present'
){
    include openbsd::network
    file{"/etc/${fileprefix}.${name}":
        content => "${content}\n",
        notify => Exec['restart_network'],
        ensure => $ensure,
        owner => root, group => 0, mode => 0640;
    }
}
