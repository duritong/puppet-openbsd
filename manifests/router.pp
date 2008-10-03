# manifests/router.pp

# settings needed for a router
class openbsd::router {
    sysctl::set_value{"net.inet.ip.forwarding": value => "1"}
    sysctl::set_value{"net.inet.ip6.forwarding": value => "1"}
}
