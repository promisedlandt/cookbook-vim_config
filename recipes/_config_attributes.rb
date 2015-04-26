unless node[:vim_config][:vimrc][:config][:system_wide].nil?
  template node[:vim_config][:config_file_path] do
    source "vimrc.erb"
    owner  "root"
    group  "root"
    mode   00644
    variables config: node[:vim_config][:vimrc][:config][:system_wide]
  end
end

unless node[:vim_config][:vimrc][:config][:user_specific].nil?
  node[:vim_config][:vimrc][:config][:user_specific].each do |user, config|
    if node["etc"]["passwd"][user]
      template ::File.join(node["etc"]["passwd"][user]["dir"], ".vimrc") do
        source "vimrc.erb"
        owner  user
        group  node["etc"]["passwd"][user]["gid"]
        mode   00644
        variables config: config
      end
    end
  end
end
