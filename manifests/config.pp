# == Class: flyway
#
# Install and configures Flyway
#
# === Parameters
#
# === Examples
#
# === Authors
#
# Steven Bambling <smbambling@arin.net>
#
# === Copyright
#
# Copyright 2015
#
class flyway::config { 

  $concat_target_flyway_conf = "${flyway::flyway_destination}/conf/flyway.conf"

  concat { $concat_target_flyway_conf:
    ensure => present,
    owner  => $flyway::flyway_user,
    group  => $flyway::flyway_group,
    mode   => '0755',
  }

  require ::file_header
  concat::fragment { 'puppet_header':
    target  => $concat_target_flyway_conf,
    content => template("$::file_header::pound_header"),
    order   => '00',
  }

  concat::fragment { 'flyway.conf_main':
    target  => $concat_target_flyway_conf,
    content => template('flyway/flyway.conf.erb'),
    order   => '01',
  }

}
