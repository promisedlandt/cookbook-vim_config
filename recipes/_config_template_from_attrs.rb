#
# Cookbook Name:: vim_config
# Recipe:: _config_template_from_attrs
#
# Author:: Alexey Mochkin <alukardd@alukardd.org>
#
# Software distributed on an "AS IS" BASIS, WITHOUT WARRANTIES
# OR CONDITIONS OF ANY KIND, either express or implied.
#
#^syntax detection
# vim: ts=2 sw=2 expandtab

unless node[:vim_config][:vimrc][:config][:system_wide].nil?
  template node[:vim_config][:config_file_path] do
    source "vimrc.erb"
    owner  "root"
    group  "root"
    mode   "00644"
    variables :config => node[:vim_config][:vimrc][:config][:system_wide]
  end
end

unless node[:vim_config][:vimrc][:config][:user_specific].nil?
  node[:vim_config][:vimrc][:config][:user_specific].flatten.uniq.each do |user|
    if  Mixlib::ShellOut.new("id #{user}").run_command.exitstatus == 0
      home = Mixlib::ShellOut.new("echo ~#{user}").run_command.stdout.chomp!

      directory "#{home}" do
        owner "#{user}"
        group "#{user}"
        mode 0755
        recursive true
        action :create
      end

      template "#{home}/.vimrc" do
        source "vimrc.erb"
        owner  "root"
        group  "root"
        mode   "00644"
        variables :config => node[:vim_config][:vimrc][:config][:user_specific][user]
      end
    end
  end
end
