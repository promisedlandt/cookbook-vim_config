add_vim_git_plugin({ "vundle"   => "https://github.com/gmarik/vundle.git",
                     "unbundle" => "https://github.com/sunaku/vim-unbundle.git",
                     "pathogen" => "https://github.com/tpope/vim-pathogen.git" }[node[:vim_config][:plugin_manager].to_s])

case node[:vim_config][:plugin_manager]
  when "pathogen"
    node.override[:vim_config][:vimrc][:config][:system_wide] = node[:vim_config][:vimrc][:config][:system_wide].dup << "" << "source #{node[:vim_config][:bundle_dir]}/vim-pathogen/autoload/pathogen.vim" << "execute pathogen#infect('#{node[:vim_config][:bundle_dir]}/{}', 'bundle/{}')"
end
