#
# Cookbook Name:: vim_config
# Recipe:: _plugin_manager_vundle
#
# Copyright 2011, Nils Landt
#
# All rights reserved - Do Not Redistribute
#

git ::File.join(node["vim_config"]["bundle_dir"], "vundle") do
  repository "https://github.com/gmarik/vundle.git"
  reference "master"
end
