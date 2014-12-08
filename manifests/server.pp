# Class: snmp::server
#
#
class snmp::server (
  $syslocation   = 'unknown',
  $syscontact    = '',
  $allowed_hosts = [],
){
  package { 'net-snmp':
    ensure => installed,
  }

  service { 'snmpd':
    ensure  => running,
    enable  => true,
    require => Package['net-snmp'],
  }

  concat { '/etc/snmp/snmpd.conf':
    ensure => present,
    notify => Service['snmpd'],
  }

  concat::fragment { 'snmpd.conf.header':
    target  => '/etc/snmp/snmpd.conf',
    content => template('snmp/snmpd.conf.header.erb'),
    order   => '01',
  }

  firewall { '100 allow snmp':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '161',
    proto  => 'udp',
    action => 'accept',
  }
}
