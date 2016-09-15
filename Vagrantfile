Vagrant.configure("2") do |config|
  config.vm.define "chef_server", primary: true do |web|
  web.vm.box = "ubuntu/trusty64"
  web.vm.hostname = "chefserver"
  web.vm.network "private_network", ip: "192.168.100.115"
  web.vm.provider "virtualbox" do |host|
	host.name="chefserver"
	host.cpus = 2
	host.memory = 4096 
	end
  web.vm.provision "shell", inline: "echo chef_2"
  end
config.vm.provision "shell", inline: <<-SHELL
echo "This host is ready for provisioning" 
SHELL
end
