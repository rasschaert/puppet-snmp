# Class: snmp
#
#
class snmp {
  contain snmp::server
  contain snmp::client
}
