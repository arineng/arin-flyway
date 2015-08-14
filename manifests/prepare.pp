#class: flyway::prepare
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
class flyway::prepare (
  $manage_user         = $flyway::manage_user,
  $flyway_user         = $flyway::flyway_user,
  $flyway_group        = $flyway::flyway_group,
  $flyway_gid          = $flyway::flyway_gid,
  $flyway_uid          = $flyway::flyway_uid,
  $flyway_user_comment = $flyway::flyway_user_comment,
  $flyway_destination  = $flyway::flyway_destination,
) inherits ::flyway {

  if $manage_user {

    group { $flyway_group:
      ensure => present,
      gid    => $flyway_gid,
    }

    user { $flyway_user:
      ensure  => present,
      uid     => $flyway_uid,
      gid     => $flyway_gid,
      groups  => $flyway_group,
      shell   => '/bin/bash',
      home    => $flyway_destination,
      comment => $flyway_user_comment,
      require => Group[$flyway_group],
    }
  }

  file { $flyway_destination:
    ensure  => directory,
    owner   => $flyway_user,
    group   => $flyway_group,
    mode    => '0755',
    require => User[$flyway_user],
  }

}
