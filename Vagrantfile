Vagrant.configure("2") do |config|
  config.vm.define "master", primary: true do |web|
  web.vm.box = "sbeliakou/centos-6.7-x86_64"
  web.vm.hostname = "chef1"
  web.vm.network "private_network", ip: "192.168.100.111"
  web.vm.provider "virtualbox" do |host|
	host.name="chef1"
	host.cpus = 2
	host.memory = 2048 
	end
  web.vm.provision "shell", inline: "echo chef_1"
  end
  config.vm.define "slave", primary: true do |web|
  web.vm.box = "sbeliakou/centos-6.7-x86_64"
  web.vm.hostname = "chef2"
  web.vm.network "private_network", ip: "192.168.100.112"
  web.vm.provider "virtualbox" do |host|
	host.name="chef2"
	host.cpus = 2
	host.memory = 2048 
	end
  web.vm.provision "shell", inline: "echo chef_2"
  end
config.vm.provision "shell", inline: <<-SHELL
yum install -y chef-12.13.37-1.el6.x86_64.rpm chefdk-0.17.17-1.el6.x86_64.rpm
cp -R /vagrant/.chef ~/
cp -R /vagrant/cookbooks ~/
chef-solo -c /root/.chef/solo.rb > /vagrant/output_task_7.log
echo "This host is ready for provisioning" 
SHELL
end
