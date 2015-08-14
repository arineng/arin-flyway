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
class flyway::install (
  $source_url          = $flyway::source_url,
  $flyway_destination  = $flyway::flyway_destination,
  $flyway_user         = $flyway::flyway_user,
  $flyway_group        = $flyway::flyway_group,
  $nexus_url           = $flyway::nexus_url,
  $nexus_repository    = $flyway::nexus_repository,
  $nexus_gav           = $flyway::nexus_gav,
  $nexus_packaging     = $flyway::nexus_packaging,
  $nexus_classifier    = $flyway::nexus_classifier,
  $nexus_checksum_type = $flyway::nexus_checksum_type,
) {

  # Include archive class to install required faraday gems
  include ::archive

  if ( $source_url ) and ( $nexus_url == undef ) {

    $install_file = inline_template('<%=File.basename(URI::parse(@source_url).path)%>')

    archive { "/tmp/${install_file}":
      source        => $source_url,
      extract       => true,
      extract_path  => $flyway_destination,
      creates       => "${flyway_destination}/README.txt",
      user          => $flyway_user,
      group         => $flyway_group,
      extract_flags => '--strip-components=1 -zxf'
    }
  }
  elsif ( $nexus_url != undef ) {
    archive::nexus { "/tmp/flyway.${nexus_packaging}":
      ensure        => present,
      checksum_type => $nexus_checksum_type,
      url           => $nexus_url,
      gav           => $nexus_gav,
      repository    => $nexus_repository,
      packaging     => $nexus_packaging,
      classifier    => $nexus_classifier,
      owner         => $flyway_user,
      user          => $flyway_user,
      group         => $flyway_group,
      extract       => true,
      extract_path  => $flyway_destination,
      creates       => "${flyway_destination}/README.txt",
      require       => Class['archive'],
    }
  }
  
}
