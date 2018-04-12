# == Class: rpmrepo::repocfg
# ==========================
#
# Add yum repositiry to config
#
# Include this class to add our local yum repositiry on your node
#
# @example
#   include rpmrepo::repocfg
#
#
define rpmrepo::repocfg (
  $reponame,
  $url,
  $subpath,
  ) {
  yumrepo { "repo-${title}":
    enabled  => 1,
    descr    => "${reponame}",
    baseurl  => "${url}/${subpath}",
    gpgcheck => 0,
    priority => 1,
  }
}
