require 'berkshelf/vagrant'

Vagrant::Config.run do |top_config|
  top_config.vm.define :git do |config|
    config.vm.host_name = "vim-config-git-berkshelf"

    config.vm.box = "debian-6.0.6"

    config.vm.network :hostonly, "33.33.33.199"

    config.ssh.max_tries = 40
    config.ssh.timeout   = 120

    config.vm.provision :chef_solo do |chef|
      chef.run_list = [
        "recipe[vim_config::default]"
      ]

      chef.json = {
        :vim_config => {
          :bundles => {
            "git" => [ "git://github.com/scrooloose/nerdcommenter.git",
                       "git://github.com/tpope/vim-endwise.git" ]
          }
        }
      }
    end
  end

  top_config.vm.define :hg do |config|
    config.vm.host_name = "vim-config-hg-berkshelf"

    config.vm.box = "debian-6.0.6"

    config.vm.network :hostonly, "33.33.33.200"

    config.ssh.max_tries = 40
    config.ssh.timeout   = 120

    config.vm.provision :chef_solo do |chef|
      chef.run_list = [
        "recipe[vim_config::default]"
      ]

      chef.json = {
        :vim_config => {
          :bundles => {
            "hg" => [ "https://bitbucket.org/delroth/vim-ack" ]
          }
        }
      }
    end
  end

end
