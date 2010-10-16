# manifests/router.pp

# settings needed for a router
class openbsd::router {
    sysctl::value{"net.inet.ip.forwarding": value => "1"}
    sysctl::value{"net.inet6.ip6.forwarding": value => "1"}
}
