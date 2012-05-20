def initialize *args
  super
  @action = :create
end

require 'fileutils'
require 'open-uri'
include VimSiteFiles

action :create do
  install_file_to_directory new_resource.name, new_resource.version, node[:vim_config][:bundle_dir], node[:vim_config][:owner], node[:vim_config][:owner_group], node[:vim_config][:force_bundle_update]
end
