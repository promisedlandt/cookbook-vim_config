#
# Cookbook Name:: vim_config
# Recipe:: _plugin_manager_pathogen
#
# Copyright 2011, Nils Landt
#
# All rights reserved - Do Not Redistribute
#

git ::File.join(node["vim_config"]["bundle_dir"], "vim-pathogen") do
  repository "git://github.com/tpope/vim-pathogen.git"
  reference "master"
end
