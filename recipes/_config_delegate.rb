#
# Cookbook Name:: vim_config
# Recipe:: _config_delegate
#
# Copyright 2011, Nils Landt
#
# All rights reserved - Do Not Redistribute
#

cookbook_file node["vim_config"]["config_file_path"] do
  source "vimrc.local.delegated"
  owner node["vim_config"]["owner"]
  group node["vim_config"]["owner_group"]
  mode "0644"
end
