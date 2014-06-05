# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = "trusty64"
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

  # config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :private_network, ip: "192.168.33.41"

  # config.vm.synced_folder "../data", "/vagrant_data"

  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "puppet/manifests"
  #   puppet.module_path = "puppet/modules"
  #   puppet.manifest_file  = "init.pp"
  # end

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'apt'
    chef.add_recipe 'ruby_build'
    chef.add_recipe 'rbenv::user'
    chef.add_recipe 'rbenv::vagrant'

    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ['2.1.2'],
          global: '2.1.2',
          gems: {
            '2.1.2' => [
              {name: 'bundler'}
            ]
          }
        }]
      }
    }
  end
end
