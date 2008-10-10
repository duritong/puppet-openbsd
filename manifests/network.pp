# manifests/network.pp

class openbsd::network {
    # we only notify the root
    # to restart the box, as this
    # is more safe than to directly 
    # restart the network
    exec{'restart_network':
        command => "echo 'This host should be restarted as its network config changed' | mail -s 'Network change: restart ${fqdn}'"
        refreshonly => true,
    }
}
