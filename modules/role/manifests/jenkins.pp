class role::jenkins::master {
    include profile::basenode
    include profile::jenkins::master
    include profile::rpmrepo
}
