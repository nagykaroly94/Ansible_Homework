# -*- mode: ruby -*-
# vi: set ft=ruby :

$etchosts = <<-SCRIPT
cp /etc/hosts /root && \
echo '\n192.168.56.251 ansible' >> /etc/hosts && \
echo '192.168.56.250 web' >> /etc/hosts
SCRIPT

Vagrant.configure("2") do |config|



  config.vm.define "web" do |web|
    web.vm.box = "bento/rockylinux-9"
    web.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
    web.vm.network "private_network", ip: "192.168.56.250"
    web.vm.synced_folder "./shared", "/shared"
    web.vm.provision "shell", inline: $etchosts
    web.vm.provision "shell", inline: "sudo useradd -m -p '$y$j9T$nUukaRx3zhLvN7WaqW.pO.$uD/UL7wcsvTgMknKv5Cq5EEfBZQ0Ak0RHPX7X6l3Tl1' homework"
    web.vm.provision "shell", inline: "sudo hostnamectl set-hostname web"
    web.vm.provision "shell", inline: "sudo usermod -aG wheel homework"
    web.vm.network "forwarded_port", guest:80, host:8888
  end


  config.vm.define "ansible" do |ansible|
    ansible.vm.box = "bento/rockylinux-9"
    ansible.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
    end
    ansible.vm.network "private_network", ip: "192.168.56.251"
    ansible.vm.hostname = "ansible"
    ansible.vm.synced_folder "./shared", "/shared"
    ansible.vm.provision "shell", inline: $etchosts
    ansible.vm.provision "shell", path: "./provision/ansible.sh"
    ansible.vm.provision "shell", inline: "sudo su"
    ansible.vm.provision "shell", inline: "sudo ssh-keyscan -H 192.168.56.250 >> ~/.ssh/known_hosts"
    ansible.vm.provision "shell", inline: "ansible-playbook -i /shared/inventory.ini /shared/nginx_install.yml"
  end
end
