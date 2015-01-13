# original tutorial http://www.sitepoint.com/vagrantfile-explained-setting-provisioning-shell/
# original github https://github.com/sitepoint-editors/vagrant-base-config

Vagrant.configure("2") do |config|
  
  # Specify the base box
  config.vm.box = "primalskill/ubuntu-trusty64"
  
  # Setup port forwarding
  config.vm.network :forwarded_port, guest: 80, host: 8931, auto_correct: true

    # Setup synced folder
    config.vm.synced_folder "./", "/var/www", create: true, group: "www-data", owner: "www-data"

    # VM specific configs
    config.vm.provider "virtualbox" do |v|
      v.name = "SitePoint Test Vagrant"
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    # Shell provisioning
    config.vm.provision "shell" do |s|
      s.path = "provision/setup.sh"
    end
end