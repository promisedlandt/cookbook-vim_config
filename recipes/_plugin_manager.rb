add_vim_git_plugin({ "vundle"   => "https://github.com/gmarik/vundle.git",
                     "unbundle" => "https://github.com/sunaku/vim-unbundle.git",
                     "pathogen" => "https://github.com/tpope/vim-pathogen.git" }[node[:vim_config][:plugin_manager].to_s])
