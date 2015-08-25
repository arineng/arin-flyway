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
class flyway::prepare { 

  if $flyway::manage_user {

    group { $flyway::flyway_group:
      ensure => present,
      gid    => $flyway::flyway_gid,
    }

    user { $flyway::flyway_user:
      ensure  => present,
      uid     => $flyway::flyway_uid,
      gid     => $flyway::flyway_gid,
      groups  => $flyway::flyway_group,
      shell   => '/bin/bash',
      home    => $flyway::flyway_destination,
      comment => $flyway::flyway_user_comment,
      require => Group[$flyway::flyway_group],
    }
  }

  file { $flyway::flyway_destination:
    ensure  => directory,
    owner   => $flyway::flyway_user,
    group   => $flyway::flyway_group,
    mode    => '0755',
    require => User[$flyway::flyway_user],
  }

}
