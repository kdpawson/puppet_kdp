# SSH Service and Configuration for both Ubuntu and CentOS systems
# Version 1.0 - July 2014
class ssh_config {
  case $::operatingsystem {
    'Ubuntu':  { $service_name  = 'ssh'
}
    'CentOS':  { $service_name  = 'sshd'
    }

    default:  {
    fail("${::operatingsystem} is not a supported operating system") }
}

  service { $service_name :
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/ssh/sshd_config'],
  }

  file  { '/etc/ssh/sshd_config':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///files/ssh/sshd_config.${operatingsystem}",
    #notify => service
  }

}
