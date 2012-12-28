#
# Cookbook Name:: vim_config
# Recipe:: _plugin_manager_unbundle
#
# Copyright 2011, Nils Landt
#
# All rights reserved - Do Not Redistribute
#

git ::File.join(node["vim_config"]["bundle_dir"], "vim-unbundle") do
  repository "git://github.com/sunaku/vim-unbundle.git"
  reference "master"
end
