name             "vim_config"
maintainer       "Nils Landt"
maintainer_email "cookbooks@promisedlandt.de"
license          "MIT"
description      "Configures vim and installs vim plugins"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "2.0.0"

%w(git mercurial).each { |dep| depends dep }
%w(debian ubuntu).each { |os| supports os }
