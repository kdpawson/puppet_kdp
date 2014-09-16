# node.pp file for Winnet Intranet Network
# Version 1.4 - August 2014
# V1.1 Added users class
# V1.2 Added aptsource class for iinet apt sources.list file
# V1.3 Added tt-rss service
# V1.4 Added GIT for version control to replicate to MackerNG
#
# All Nodes OS Independent Ubuntu and CentOS Linux Servers Tested
#
# NTPD configuration
class { '::ntp':
    servers => [ '172.16.16.1' ],
}

# SSH Service and configuration
include ssh_config

# Include users on system with usual password set and home directory
include users

# Ubuntu Debian Based Nodes with different requirements
case $hostname {
snapper: { include nginx }
stingrayii: { include apache,mail }
rockhopperii: { include apache,munin,tt-rss }
}

# Rsyslog Configuration class
if $hostname == 'stingrayii' {}
else { include rsyslog_config }

node 'whiting','mackerelng','atlantisng','rockhopperii','stingrayii','gummy','garfish2' {

# Add the APT module for unattended updates/upgrades
include apt::unattended_upgrades
# Sources with iinet repo for 14.04 and 12.04
include aptsource

#Packages for Ubuntu Servers
Package { ensure => 'installed' }
  $enhancers = [ 'htop', 'mc', 'ngrep', 'git', 'tree' ]
  $enhancers2 = [ 'tmux', 'dstat', 'ethstatus', 'byobu', 'logwatch' ]
  package { $enhancers: }
  package { $enhancers2: }

# Files for the system e.g scripts
file { '/home/keith/scripts' :
  ensure  =>  'directory',
  recurse =>  true,
  force   =>  true,
  owner   =>  'keith',
  group   =>  'keith',
  mode    =>  '0655',
}
file { '/home/keith/scripts/vimcustom.sh' :
  source  =>  'puppet:///files/vimcustom.sh',
  owner   =>  'keith',
  group   =>  'keith',
  mode    =>  '0655',
  require =>  File['/home/keith/scripts'],
}
file { '/home/keith/scripts/netck2.sh' :
  source  =>  'puppet:///files/netck2.sh',
  owner   =>  'keith',
  group   =>  'keith',
  mode    =>  '0655',
  require =>  File['/home/keith/scripts'],
}
file { '/home/keith/scripts/vimrc' :
  source  =>  'puppet:///files/vimrc',
  owner   =>  'keith',
  group   =>  'keith',
  mode    =>  '0664',
  require =>  File['/home/keith/scripts'],
}
file { '/home/keith/scripts/git-puppet.txt' :
  source  =>  'puppet:///files/git-puppet.txt',
  owner   =>  'keith',
  group   =>  'keith',
  mode    =>  '0664',
  require =>  File['/home/keith/scripts'],
}
}
# CentOS Nodes
node 'walung','flounder','whitebait2' {
case $hostname {
  walung:  { include httpd }
  }
# Add the EPEL repo Module
include epel
# Yum AutoUpdate module and configuration
class { '::autoupdate':
  email_to   => 'metis@winnet.kdp',
  email_from => 'yumupdates@winnet.kdp',
}

#include httpd

# Packages for Server
Package { ensure => 'installed' }
  package { 'htop' : }
  package { 'tree' : }
  package { 'mc' : }
  package { 'dstat' : }
  package { 'logwatch' : }

# Files for the system e.g scripts
file { '/home/keith/scripts' :
  ensure  =>  'directory',
  recurse =>  true,
  force   =>  true,
  owner   =>  'keith',
  group   =>  'keith',
  mode    =>  '0655',
}
file { '/home/keith/scripts/vimcustom.sh' :
  source  =>  'puppet:///files/vimcustom.sh',
  owner   =>  'keith',
  group   =>  'keith',
  mode    =>  '0655',
  require =>  File['/home/keith/scripts'],
        }
file { '/home/keith/scripts/netck2.sh' :
  source  =>  'puppet:///files/netck2.sh',
  owner   =>  'keith',
  group   =>  'keith',
  mode    =>  '0655',
  require =>  File['/home/keith/scripts'],
  }
file { '/home/keith/scripts/vimrc' :
  source  =>  'puppet:///files/vimrc',
  owner   =>  'keith',
  group   =>  'keith',
  mode    =>  '0664',
  require =>  File['/home/keith/scripts'],
  }
}
