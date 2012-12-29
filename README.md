Description
===========

This cookbook helps you manage your vim plugins and configuration.

Requirements
============

Vim configuration and vim plugins would be silly without vim.

Git will be installed via the default git cookbook. If you do not wish this, set `node["vim_config"]["skip_git_installation"] = true`.  
In case you have queued up any plugins in mercurial repositories, mercurial will be installed. You can prevent this by setting `node["vim_config"]["skip_mercurial_installation"] = true`.

If you want to install compressed plugins, `unzip`, `tar` and `gunzip` need to be available on the node (depending on the file's ending). This is not a cookbook dependency though.

Installation directory
======================

Everything will be installed to "/etc/vim", the better to manage your systemwide vim installation. You can switch to a different directory by setting `node["vim_config"]["installation_dir"]`.

If you don't want everything to belong to root:root, change `node["vim_config"]["owner"]` and `node["vim_config"]["owner_group"]`.

Configuration
=============

The main configuration file is called "vimrc.local" by default, because that's how things work on Debian. If you want to rename it, set `node["vim_config"]["config_file_name"]`.

# Via wrapper cookbook

Set `node["vim_config"]["config_file_mode"] = :cookbook`, `node["vim_config"]["config_file_template"]` to the name of the template file to use and `node["vim_config"]["config_file_cookbook"]` to the name of your wrapper cookbook.

**This is the preferred way of including your vimrc**

An example wrapper cookbook can be found [here](https://github.com/promisedlandt/cookbook-role_vim)

# Via template

Set `node["vim_config"]["config_file_mode"]` to `:template` (or don't set it at all, since `:template` is the default).

Then fork this cookbook and copy your vimrc into `templates/default/vimrc.local.erb`.

# Via remote file

Set `node["vim_config"]["config_file_mode"]` to `:remote_file`, then set `node["vim_config"]["remote_config_url"]` to the URL of your vimrc.

# Via snippets

Instead of a monolithic configuration file, you might want to split your config in smaller chunks like "tab management", "pathogen", "ctrlp" etc..

Snippets will be downloaded into a "config.d" subdirectory inside your installation directory.

Set `node["vim_config"]["config_files"]` to an array of URLs to your snippets.

## Concatenated

Set `node["vim_config"]["config_file_mode"]` to `:concatenate`.  
All the snippets will be concatenated into the main config file.

## Delegated

Set `node["vim_config"]["config_file_mode"]` to `:delegate`.  
All the snippets will be loaded when you start vim.

Plugins
=======

Plugins will be installed into a "bundle" directory under your installation directory by default. Feel free to change this by setting `node["vim_config"]["bundle_dir"]`.

# Plugin Manager

Set the plugin manager in `node["vim_config"]["plugin_manager"]`. One of `:pathogen`, `:unbundle` or `:vundle`.

The selected plugin manager will be installed automatically, but you will have to call it in your vimrc manually.

# Git

Fill the `node["vim_config"]["bundles"]["git"]` array with URLs to git repositories of plugins you want to use, e.g.

    default_attributes  "vim_config" { "bundles" { 
                                               "git" => [ "git://github.com/scrooloose/nerdcommenter.git",
                                                          "git://github.com/tpope/vim-endwise.git" ] 
    }}

# Mercurial

Fill the `node["vim_config"]["bundles"]["hg"]` array with URLs to mercurial repositories of plugins you want to use, e.g.

    default_attributes  "vim_config" { "bundles" { 
                                               "hg" => [ "https://bitbucket.org/delroth/vim-ack" ] 
    }}

This needs the mercurial LWRP, so make sure to include the [mercurial cookbook](http://community.opscode.com/cookbooks/mercurial).

# vim.org

You can also use plugins directly from [vim.org](http://vim.org).  

Fill the `node["vim_config"]["bundles"]["vim"]` hash, with the key being the name of the subdirectory that will be created in your bundles dir, adn the value being the "src_id" URL parameter for the version you want to download.

For example, if you wanted to use [LargeFile](http://www.vim.org/scripts/script.php?script_id=1506) (go on, click the link!), your key might be "largefile" or "largefile-1506", and your value for the newest version would be "9277", because the download URL is "http://www.vim.org/scripts/download_script.php?src_id=9277".

    default_attributes  "vim_config" { "bundles" { 
                                                 "vim" { "largefile-1506" => "9277",
                                                         "genutils-197" => "11399"
                                                       } 
    }}

This is mostly obsolete because [Vim Scripts](http://vim-scripts.org) exists.

Forcing Updates
===============

This cookbook does not update vim site plugins and config snippets.  
You can set `node["vim_config"]["force_update"]` to `true`, and all plugins / config snippets will be deleted and re-downloaded on every run.


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

# vim_config_vim

## Actions

:create (default): creates the plugin.

## Attributes

name (name attribute): directory name for the plugin

version: "script_id" URL parameter on vim.org

force: if true, will overwrite plugin every time. Defaults to `false`.

Acknowledgments
===============

It all clicked for me when I read Tammer Saleh's ["The Modern Vim Config with Pathogen"](http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen).  
The article got me started with [pathogen](https://github.com/tpope/vim-pathogen), using [this script](https://gist.github.com/593551) to manage my plugins.

All handling of the plugins from vim.org is copied and only slightly modified from that script, which was created by [Daniel C](https://github.com/theosp).
