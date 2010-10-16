# manifests/carp.pp
# settings needed to use carp

class openbsd::carp {
    sysctl::value{"net.inet.carp.preempt": value => "1"}
}
