# User Keith config
# Version 1.0 July 2014
#
class users {

# Add sha password hash for user in * area
# User Keith:
  user  { 'keith' :
  ensure     => present,
  gid        => 'keith',
  home       => '/home/keith',
  managehome => true,
  password   => '$6$salt$************'
}
  group { 'keith' :
    ensure => present,
  }
}
