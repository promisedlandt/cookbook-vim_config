# Description

This cookbook helps you manage your vim plugins and configuration.

# Update notes from previous versions

  * Downloading plugins from the official site has been deprecated. It still works, but is no longer documented. Use [vim-scripts](https://github.com/vim-scripts) instead.
  * Config file modes "concatenate" and "delegate" deprecated. Still works, but undocumented.

# Examples

```
# Install the nerdcommenter and endwise plugins via git
node.set[:vim_config][:bundles][:git] = [ "git://github.com/scrooloose/nerdcommenter.git",
                                          "git://github.com/tpope/vim-endwise.git" ] 

# Install the vim-ack plugin via mercurial
node.set[:vim_config][:bundles][:hg] = [ "https://bitbucket.org/delroth/vim-ack" ]

# Download our vimrc from github
node.set[:vim_config][:config_file_mode] = :remote_file
node.set[:vim_config][:remote_config_url] = "https://raw.github.com/promisedlandt/dotfiles/.vimrc"

# Execute
include_recipe "vim_config"
```

# Platforms

Tested on Ubuntu and Debian. Check [.kitchen.yml](https://github.com/promisedlandt/cookbook-vim_config/.kitchen.yml) for the exact versions tested.

# Prerequisites

Vim configuration and vim plugins would be silly without vim, but you will have to handle that installation yourself.

Git will be installed via the default git cookbook. If you do not wish this, set `node[:vim_config][:skip_git_installation] = true`.  
In case you have queued up any plugins in mercurial repositories, mercurial will be installed. You can prevent this by setting `node[:vim_config][:skip_mercurial_installation] = true`.

# Recipes

## vim_config::default

Installs git, the plugin manager of your choice, optionally mercurial, all specified plugins and, optionally, your vimrc.

# Attributes

All attributes are under the `:vim_config` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
installation_dir | This is where your stuff will be installed to | String | /etc/vim
bundle_dir | Path where your plugins will be installed to | String | installation_dir/bundle

owner | Owner of all files / directories created by this cookbook | String | root
owner_group | Group of all files / directories created by this cookbook | String | root

plugin_manager | Plugin manager to use. Currently supported are "pathogen", "unbundle" and "vundle" | String | pathogen

config_file_mode | Where to get config file from. Currently supported are "cookbook", "template" and "remote_file". See appropriate section in this readme | String | template
config_file_name | Name of the config file as it will end up on the file system | String | vimrc.local
config_file_cookbook | Used when config_file_mode is "cookbook". Name of the wrapper cookbook to get the config file from | String | nil

Plugin bundle attributes are under the `[:vim_config][:bundles]` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
git | Array of URLs of plugins to install via git | Array | []
hg | Array of URLs of plugins to install via mercurial | Array | []

# Configuration

There are three ways to get your configuration file installed.

## Via wrapper cookbook

Set `node[:vim_config][:config_file_mode] = :cookbook`, `node[:vim_config][:config_file_template]` to the name of the template file to use and `node[:vim_config][:config_file_cookbook]` to the name of your wrapper cookbook.

**This is the preferred way of including your vimrc**

An example wrapper cookbook can be found [here](https://github.com/promisedlandt/cookbook-role_vim)

## Via template

Set `node[:vim_config][:config_file_mode]` to `:template` (or don't set it at all, since `:template` is the default).

Then fork this cookbook and copy your vimrc into `templates/default/vimrc.local.erb`.

## Via remote file

Set `node[:vim_config][:config_file_mode]` to `:remote_file`, then set `node[:vim_config][:remote_config_url]` to the URL of your vimrc.

# Plugins

Plugins will be installed into a "bundle" directory under your installation directory by default. Feel free to change this by setting `node[:vim_config][:bundle_dir]`.

## Plugin Manager

Set the plugin manager in `node[:vim_config][:plugin_manager]`. One of `:pathogen`, `:unbundle` or `:vundle`.

The selected plugin manager will be installed automatically, but you will have to manually edit your vimrc according to your plugin manager's instructions.

# Git

Fill the `node[:vim_config][:bundles][:git]` array with URLs to git repositories of plugins you want to use, e.g.

    default_attributes  vim_config: { bundles: { 
                                               git: [ "git://github.com/scrooloose/nerdcommenter.git",
                                                      "git://github.com/tpope/vim-endwise.git" ] 
    }}

# Mercurial

Fill the `node[:vim_config][:bundles][:hg]` array with URLs to mercurial repositories of plugins you want to use, e.g.

    default_attributes  vim_config: { bundles: { 
      hg: [ "https://bitbucket.org/delroth/vim-ack" ] 
    }}

This needs the mercurial LWRP, so make sure to include the [mercurial cookbook](http://community.opscode.com/cookbooks/mercurial).


Resources / Providers
=====================

# vim_config_git

## Actions

:create (default): creates the plugin.

## Attributes

repository (name attribute): URL to the repository

reference: branch, defaults to "master"

# vim_config_mercurial

## Actions

:create (default): creates the plugin.

## Attributes

repository (name attribute): URL to the repository

reference: branch, defaults to "tip"

Acknowledgments
===============

It all clicked for me when I read Tammer Saleh's ["The Modern Vim Config with Pathogen"](http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen).  
The article got me started with [pathogen](https://github.com/tpope/vim-pathogen), using [this script](https://gist.github.com/593551) to manage my plugins.

All handling of the plugins from vim.org is copied and only slightly modified from that script, which was created by [Daniel C](https://github.com/theosp).
