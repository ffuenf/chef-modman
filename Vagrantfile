def abspath(f)
  File.expand_path("../#{f}", __FILE__)
end

Vagrant.configure('2') do |config|

  # vagrant-omnibus
  if Vagrant.has_plugin?('vagrant-omnibus')
    config.omnibus.chef_version = :latest
    config.omnibus.cache_packages = true
  end

  # vagrant-berkshelf
  config.berkshelf.enabled = true if Vagrant.has_plugin?('vagrant-berkshelf')

  # vagrant-cachier
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :machine
    config.cache.synced_folder_opts = {
      type: :nfs,
      mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    }
    config.cache.enable :generic, 'wget' => { cache_dir: '/var/cache/wget' }
  end

  # network
  config.vm.network 'private_network', ip: '10.0.0.50'

  # basebox
  config.vm.box = 'ffuenf/debian-7.6.0-amd64'

  # virtualbox options
  config.vm.provider 'virtualbox' do |v|
    v.gui = false
    v.customize ['modifyvm', :id, '--memory', 2048]
    v.customize ['modifyvm', :id, '--cpus', 2]
    v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    v.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
  end

  # Configure Chef Solo provisioner
  config.vm.provision 'chef_solo' do |chef|
    chef.cookbooks_path = 'vendor/cookbooks'
    # Load node attributes and run list from a JSON file
    json_file =
    if File.exist?(abspath('Vagrantfile.chef.json'))
      abspath('Vagrantfile.chef.json')
    end
    chef.json = JSON.parse(IO.read(json_file))

    # Configure Chef output
    chef.custom_config_path = 'Vagrantfile.config'
  end
end
