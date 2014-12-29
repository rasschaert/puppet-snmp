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

  concat { '/etc/snmp/snmpd.conf':
    ensure => present,
    notify => Service['snmpd'],
  }

  concat::fragment { 'snmpd.conf.header':
    target  => '/etc/snmp/snmpd.conf',
    content => template('snmp/snmpd.conf.header.erb'),
    order   => '01',
  }

  service { 'snmpd':
    ensure  => running,
    enable  => true,
    require => [
                  Package['net-snmp'],
                  Concat['/etc/snmp/snmpd.conf'],
                ],
  }

  firewall { '100 allow snmp requests':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '161',
    proto  => 'udp',
    action => 'accept',
  }

  firewall { '100 allow snmp notifications':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '162',
    proto  => 'udp',
    action => 'accept',
  }
}
