# Rsyslog Service and Configuration for both Ubuntu and CentOS systems
# Version 1.0 - August 2014
class rsyslog_config {

  service { rsyslog :
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/rsyslog.conf'],
  }

  file  { '/etc/rsyslog.conf':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///files/rsyslog/rsyslog.conf.${operatingsystem}",
    #notify => service
  }

}
