# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision :shell, :path => "provision.sh", :privileged => false
  config.ssh.forward_agent = true

  # For autopsy
  config.vm.network "forwarded_port", guest: 9999, host: 9999

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 4
  end
end
