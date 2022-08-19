### Загрузка 
wget https://app.vagrantup.com/bento/boxes/ubuntu-20.04/versions/202206.03.0/providers/virtualbox.box
vagrant box add bento/ubuntu-20.04 virtualbox.box
### Vagrantfile
``` bash
IMAGE_NAME = "bento/ubuntu-20.04"
Vagrant.configure(2) do |config|
  config.vm.box = IMAGE_NAME
  config.vm.box_check_update = false
  config.vm.hostname = "controlplane-1"  
  config.vm.network "public_network", bridge: "vlan1007", ip: "10.254.10.101"
  config.vm.define "controlplane-1"
  config.vm.provider "virtualbox" do |v|
     v.cpus = 2
     v.memory = 1024
  end
end
```

