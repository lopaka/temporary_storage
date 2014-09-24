name             'temporary_storage'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Provides recipes for managing temporary volumes on a Server in a RightScale supported cloud'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'filesystem', '~> 0.9.0'
depends 'marker', '~> 1.0.0'
depends 'rightscale_volume', '~> 1.2.1'

recipe 'temporary_storage::default', 'Sets up required dependencies for using this cookbook'
recipe 'temporary_storage::volume', 'Creates a temporary volume and attaches it to the server'
recipe 'temporary_storage::decommission', 'Detaches and destroys the temporary volume. This recipe should' +
  ' be used as a decommission recipe in a RightScale ServerTemplate.'

attribute 'temporary_storage/mount_point',
  :display_name => 'Temporary Volume Mount Point',
  :description => 'The mount point to mount the temporary device on. Example: /mnt/ephemeral',
  :default => '/mnt/ephemeral',
  :recipes => ['temporary_storage::volume', 'temporary_storage::decommission'],
  :required => 'recommended'

attribute 'temporary_storage/volume_size',
  :display_name => 'Temporary Volume Size',
  :description => 'Size of the volume or logical volume to create (in GB). Example: 10',
  :default => '10',
  :recipes => ['temporary_storage::volume'],
  :required => 'recommended'

attribute 'temporary_storage/volume_type',
  :display_name => 'Volume Type',
  :description => 'Volume Type to use for creating the temporary volume. Currently this value is only used on vSphere.' +
    ' Example: Platinum-Volume-Type',
  :recipes => ['temporary_storage::volume'],
  :required => 'recommended'
