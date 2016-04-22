# == Class: flyway::install
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
class flyway::install {

  # Include archive class to install required faraday gems
  contain ::archive

  # Include Java class to install java
  contain ::java

  if ( $flyway::source_url ) and ( $flyway::nexus_url == undef ) {

    $install_file = inline_template('<%=File.basename(URI::parse(@flyway::source_url).path)%>')

    archive { "/tmp/${install_file}":
      source        => $flyway::source_url,
      extract       => true,
      extract_path  => $flyway::flyway_destination,
      creates       => "${flyway::flyway_destination}/README.txt",
      user          => $flyway::flyway_user,
      group         => $flyway::flyway_group,
      extract_flags => '--strip-components=1 -zxf'
    }
  }
  elsif ( $flyway::nexus_url != undef ) {
    archive::nexus { "/tmp/flyway.${flyway::nexus_packaging}":
      ensure        => present,
      checksum_type => $flyway::nexus_checksum_type,
      url           => $flyway::nexus_url,
      gav           => $flyway::nexus_gav,
      repository    => $flyway::nexus_repository,
      packaging     => $flyway::nexus_packaging,
      classifier    => $flyway::nexus_classifier,
      owner         => $flyway::flyway_user,
      user          => $flyway::flyway_user,
      group         => $flyway::flyway_group,
      extract       => true,
      extract_path  => $flyway::flyway_destination,
      creates       => "${flyway::flyway_destination}/README.txt",
      require       => Class['archive'],
    }
  }
  
}
