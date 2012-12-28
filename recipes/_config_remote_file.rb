#
# Cookbook Name:: vim_config
# Recipe:: _config_remote_file
#
# Copyright 2011, Nils Landt
#
# All rights reserved - Do Not Redistribute
#

remote_file node["vim_config"]["config_file_path"] do
  source node["vim_config"]["remote_config_url"]
  backup false
  owner node["vim_config"]["owner"]
  group node["vim_config"]["owner_group"]
  mode "0644"
end
