# APT Sources.list file with iinet repo for Ubuntu trusty or precise servers
# Version 1.0 - August 2014
class aptsource {
case $::lsbdistcodename {
   trusty: {
  file { '/etc/apt/sources.list' :
    source => 'puppet:///files/sources.list',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  }
   precise: {
   file { '/etc/apt/sources.list' :
     source => 'puppet:///files/precise/sources.list',
     owner  => 'root',
     group  => 'root',
     mode   =>  '0644',
       }
  }
  default: {
 file { '/etc/apt/sources.list' :
   source => 'puppet:///files/sources.list',
   owner  => 'root',
   group  => 'root',
   mode   =>  '0644',
  }
  }
}
}
