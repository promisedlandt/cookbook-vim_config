#
# Cookbook Name:: vim_config
# Recipe:: default
#
# Copyright 2011, Nils Landt
#
# All rights reserved - Do Not Redistribute
#

bundle_dir = node["vim_config"]["bundle_dir"]
owner = node["vim_config"]["owner"]
group = node["vim_config"]["owner_group"]
config_file_path = ::File.join(node["vim_config"]["installation_dir"], node["vim_config"]["config_file_name"])
config_dir = ::File.join(node["vim_config"]["installation_dir"], "config.d")

if node["vim_config"]["force_update"]
  [config_dir, bundle_dir].each do |dir|
    directory dir do
      action :delete
      recursive true
    end
  end
end

directory bundle_dir do
  owner owner
  group group
  mode "0755"
  action :create
end

case node["vim_config"]["plugin_manager"].to_s
when "unbundle"
  git ::File.join(bundle_dir, "vim-unbundle") do
    repository "git://github.com/sunaku/vim-unbundle.git"
    reference "master"
  end
else
  # use pathogen
  git ::File.join(bundle_dir, "vim-pathogen") do
    repository "git://github.com/tpope/vim-pathogen.git"
    reference "master"
  end
end

case node["vim_config"]["config_file_mode"].to_s
when "template"
  template config_file_path do
    source "vimrc.local.erb"
    owner owner
    group group
    mode "0644"
  end
when "remote_file"
  remote_file config_file_path do
    source node["vim_config"]["remote_config_url"]
    backup false
    owner owner
    group group
    mode "0644"
  end
when "concatenate", "delegate"
  directory config_dir do
    owner owner
    group group
    mode "0755"
    action :create
  end

  # download all the config files
  node["vim_config"]["config_files"].each_with_index do |config_file, index|
    remote_file ::File.join(config_dir, "#{ index }-#{ config_file.split("/").last }") do
      source config_file
      backup false
      owner owner
      group group
      mode "0644"
    end
  end

  # write the config file itself
  if node["vim_config"]["config_file_mode"].to_s == "delegate"
    cookbook_file config_file_path do
      source "vimrc.local.delegated"
      owner owner
      group group
      mode "0644"
    end
  elsif node["vim_config"]["config_file_mode"].to_s == "concatenate"
    config_file_content = Dir[File.join(config_dir, "**")].collect { |file| File.open(file).read }.join("\n\n")
    config_file_content = "" if config_file_content.empty?

    file config_file_path do
      backup false
      owner owner
      group group
      mode "0644"
      content config_file_content
    end
  end
else
  log "No config file mode set, not managing config file"
end

node["vim_config"]["bundles"]["git"].each do |bundle|
  vim_config_git bundle do
    action :create
  end
end

node["vim_config"]["bundles"]["hg"].each do |bundle|
  vim_config_mercurial bundle do
    action :create
  end
end

node["vim_config"]["bundles"]["vim"].each do |name, version|
  vim_config_vim name do
    version version
    action :create
  end
end
