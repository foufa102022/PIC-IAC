Vagrant.configure("2") do |config|
  # Ajout de l'utilisateur Vagrant en tant que sudo
  config.vm.provision "shell", inline: <<-SHELL
    # Ajout de l'utilisateur Vagrant au groupe sudo
    sudo usermod -aG sudo vagrant
    # Configuration sans mot de passe pour les commandes sudo (à des fins de test seulement)
    echo "vagrant ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/vagrant
  SHELL

  # Configuration pour la première machine
  config.vm.define "ubuntu22" do |ubuntu1|
    ubuntu1.vm.box = "ubuntu/bionic64"
    ubuntu1.vm.hostname = "ubuntu22"  # Nom de la machine
    ubuntu1.vm.network "forwarded_port", guest: 80, host: 8080
    ubuntu1.vm.network "private_network", type: "dhcp"
    ubuntu1.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
    
    ubuntu1.vm.provision "ansible" do |ansible|
      ansible.playbook = "/home/foufa/MicroProjet/Vagrant/vagrant2/install-docker.yml"
    end
    ubuntu1.vm.provision "ansible" do |ansible|
      ansible.playbook = "/home/foufa/MicroProjet/Vagrant/vagrant2/docker_configuration.yml"
    end
    ubuntu1.vm.provision "ansible" do |ansible|
      ansible.playbook = "/home/foufa/MicroProjet/Vagrant/vagrant2/install_remote-terraform.yml"
    end
    ubuntu1.vm.provision "ansible" do |ansible|
      ansible.playbook = "/home/foufa/MicroProjet/Vagrant/vagrant2/deploy_container22.yml"
    end

    # Ajout d'une provision pour redémarrer la machine à la fin du provisionnement
    ubuntu1.vm.provision "shell", inline: "sudo reboot", run: "always"
  end
end
