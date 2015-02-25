add_vim_git_plugin({ "vundle"   => "https://github.com/gmarik/Vundle.vim.git",
                     "unbundle" => "git://github.com/sunaku/vim-unbundle.git",
                     "pathogen" => "git://github.com/tpope/vim-pathogen.git" }[node[:vim_config][:plugin_manager].to_s])
