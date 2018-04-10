# mysql::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql::install
class mysql::install {

package { 'mysql-community-server':
  ensure  => present,
}

}
