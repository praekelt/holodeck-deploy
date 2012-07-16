Vagrant::Config.run do |config|
  
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  
  config.vm.provision :puppet do |puppet|
    puppet.manifest_file = "holodeck.pp"
    puppet.module_path = "manifests/modules"
  end
  
  config.vm.forward_port 80, 4567
end
