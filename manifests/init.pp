# Class: snmp
#
#
class snmp {
  contain snmp::server
  contain snmp::client
  Class['snmp::client'] -> Class['snmp::server']
}
