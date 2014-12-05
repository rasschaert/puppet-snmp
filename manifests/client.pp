# Class: snmp::client
#
#
class snmp::client {
  package { 'net-snmp-utils':
    ensure => installed,
  }

  package { 'net-snmp-python':
    ensure  => installed,
  }
}
