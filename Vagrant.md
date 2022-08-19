### Загрузка образа виртуальной машины вручную, ввиду блокировки официального хранилища
``` bash
wget https://app.vagrantup.com/bento/boxes/ubuntu-20.04/versions/202206.03.0/providers/virtualbox.box
vagrant box add bento/ubuntu-20.04 virtualbox.box
```
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
     v.memory = 2048
  end
  config.vm.provision "shell", inline: "echo Меняем sshd_config; sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config"
  config.vm.provision "shell", inline: "echo Перезапускаем sshd; service sshd restart"
  config.vm.provision "shell", inline: "echo Назначем пароль для root; (echo "pass"; echo "pass") | passwd"
end
```
### Команды
- *vagrant up* - создание виртуальной машины
- *vagrant destroy* - удаление виртуальной машины
- *vagrant suspend* - отправляет в сон
- *vagrant resume* - вывести из сна
- *vagrant ssh* - удаленный доступ
- *vagrant global-status* - список виртуальных машин
- *vagrant halt* - shutdown
- *vagrant port* - показывает список проброшенных портов
- *vagrant reload* - команда перезагрузки
