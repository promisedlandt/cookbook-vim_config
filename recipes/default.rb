#
# Cookbook Name:: vim_config
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/etc/vim/bundle" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

git "/etc/vim/bundle/vim-pathogen" do
  repository "git://github.com/tpope/vim-pathogen.git"
  reference "master"
end

cookbook_file "/etc/vim/vimrc.local" do
  source "vimrc.local"
  owner "root"
  group "root"
  mode "0644"
end

if node[:vim_config][:bundles][:git]
  node[:vim_config][:bundles][:git].each do |bundle|
    vim_config_git bundle do
      action :create
    end
  end
end

if node[:vim_config][:bundles][:vim]
  node[:vim_config][:bundles][:vim].each do |name, version|
    vim_config_vim name do
      version version
      action :create
    end
  end
end
