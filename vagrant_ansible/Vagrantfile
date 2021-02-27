Vagrant.configure("2") do |config|
config.vm.box = "centos/7"
config.vm.network "private_network", ip: "192.168.33.15"
config.vm.synced_folder "./", "/home/vagrant/working", owner: 'vagrant', group: 'vagrant'
config.vm.provider "virtualbox" do |vb|
  vb.customize ["modifyvm", :id, "--audio", "none"]
end
end