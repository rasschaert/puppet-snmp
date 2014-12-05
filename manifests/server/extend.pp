# Define: snmp::server::extend
#
#
define snmp::server::extend (
  $extension_name = $title,
  $command        = '',
) {
  concat::fragment { "snmpd extend ${title}":
    target  => '/etc/snmp/snmpd.conf',
    content => template('snmp/snmpd.conf.extend.erb'),
    order   => '02',
  }
}
