# manifests/carp.pp
# settings needed to use carp

class openbsd::carp {
    sysctl::set_value{"net.inet.carp.preempt": value => "1"}
    sysctl::set_value{"net.inet.carp.arpbalance": value => "0"}
}
