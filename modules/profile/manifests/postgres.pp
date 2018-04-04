class profile::postgres {
  class { 'postgres':
    user_host => 'localhost',
  }
}