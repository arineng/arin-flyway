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
class flyway::config (
  $flyway_destination            = $flyway::flyway_destination,
  $flyway_user                   = $flyway::flyway_user,
  $flyway_group                  = $flyway::flyway_group,
  $config_url                    = $flyway::config_url,
  $config_driver                 = $flyway::config_driver,
  $config_user                   = $flyway::config_user,
  $config_password               = $flyway::config_password,
  $config_schemas                = $flyway::config_schemas,
  $config_table                  = $flyway::config_table,
  $config_locations              = $flyway::config_locations,
  $config_resolvers              = $flyway::config_resolvers,
  $config_jardirs                = $flyway::config_jardirs,
  $config_sqlmigrationprefix     = $flyway::config_sqlmigrationprefix,
  $config_sqlmigrationseparator  = $flyway::config_sqlmigrationseparator,
  $config_sqlmigrationsuffix     = $flyway::config_sqlmigrationsuffix,
  $config_encoding               = $flyway::config_encoding,
  $config_placeholderreplacement = $flyway::config_placeholderreplacement,
  $config_target                 = $flyway::config_target,
  $config_validateonmigrate      = $flyway::config_validateonmigrate,
  $config_cleanonvalidationerror = $flyway::config_cleanonvalidationerror,
  $config_baselineversion        = $flyway::config_baselineversion,
  $config_baselinedescription    = $flyway::config_baselinedescription,
  $config_baselineonmigrate      = $flyway::config_baselineonmigrate,
  $config_outoforder             = $flyway::config_outoforder,
  $config_callbacks              = $flyway::config_callbacks,
) {

  $concat_target_flyway_conf = "${flyway_destination}/conf/flyway.conf"

  concat { $concat_target_flyway_conf:
    ensure => present,
    owner  => $flyway_user,
    group  => $flyway_group,
    mode   => '0755',
  }

  include ::file::header
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
