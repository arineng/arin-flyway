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
class flyway (
  $source_url                    = $flyway::params::source_url,
  $flyway_destination            = $flyway::params::flyway_destination,
  $manage_user                   = $flyway::params::manage_user,
  $flyway_user                   = $flyway::params::flyway_user,
  $flyway_group                  = $flyway::params::flyway_group,
  $flyway_gid                    = $flyway::params::flyway_gid,
  $flyway_uid                    = $flyway::params::flyway_uid,
  $flyway_user_comment           = $flyway::params::flyway_user_comment,
  $nexus_checksum_type           = $flyway::params::nexus_checksum_type,
  $nexus_url                     = undef,
  $nexus_repository              = undef,
  $nexus_gav                     = undef,
  $nexus_packaging               = undef,
  $nexus_classifier              = undef,
  $config_url                    = undef,
  $config_driver                 = undef,
  $config_user                   = undef,
  $config_password               = undef,
  $config_schemas                = undef,
  $config_table                  = undef,
  $config_locations              = undef,
  $config_resolvers              = undef,
  $config_jardirs                = undef,
  $config_sqlmigrationprefix     = undef,
  $config_sqlmigrationseparator  = undef,
  $config_sqlmigrationsuffix     = undef,
  $config_encoding               = undef,
  $config_placeholderreplacement = undef,
  $config_target                 = undef,
  $config_validateonmigrate      = undef,
  $config_cleanonvalidationerror = undef,
  $config_baselineversion        = undef,
  $config_baselinedescription    = undef,
  $config_baselineonmigrate      = undef,
  $config_outoforder             = undef,
  $config_callbacks              = undef,
  $config_placeholders           = {},
) inherits ::flyway::params {

  validate_hash($config_placeholders)

  contain flyway::prepare
  contain flyway::install
  contain flyway::config

  Class['flyway::prepare'] ->
  Class['flyway::install'] ->
  Class['flyway::config']
}
