# manifests/network.pp

class openbsd::network {
    exec{'restart_network':
        command => '/bin/sh /etc/netstart',
        refreshonly => true,
    }
}
