# Define: snmp::server::extend
#
#
define snmp::server::extend (
  $extension_name = $title,
  $command        = '',
  $cache_duration = 5,
) {
  concat::fragment { "snmpd extend ${title}":
    target  => '/etc/snmp/snmpd.conf',
    content => template('snmp/snmpd.conf.extend.erb'),
    order   => '02',
  }
  exec { "$extension_name snmp cache duration":
    command => "snmpset -v2c -c private localhost \'NET-SNMP-EXTEND-MIB::nsExtendCacheTime.\"$extension_name\"\' i $cache_duration",
    unless  => "snmpget -v2c -c public localhost \'NET-SNMP-EXTEND-MIB::nsExtendCacheTime.\"$extension_name\"\' | grep -q -e \" $cache_duration\$\"",
    path    => '/bin',
    require =>  [
                  Class['snmp::client'],
                  Concat['/etc/snmp/snmpd.conf'],
                ]
  }
}
