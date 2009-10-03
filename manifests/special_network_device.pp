# you can manage the devices with 
# the whole content
# name: device
# content: content of the file
define openbsd::special_network_device(
    $content,
    $ensure = 'present'
){
    include openbsd::network
    file{"/etc/hostname.${name}":
        content => "${content}\n",
        notify => Exec['restart_network'],
        ensure => $ensure,
        owner => root, group => 0, mode => 0640;
    }
}
