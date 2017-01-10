# -*- mode: ruby -*-
# vi: set ft=ruby :

#Installs OpenMRS and OSCAR (Electronic Medical Records Systems)
#Installs R Studio Server
#By Bell Eapen (nuchange.ca)

$script = <<SCRIPT
  echo Starting mysql...
  /etc/init.d/mysql start

  #restarting tomcat
  echo Restarting Tomcat Server...
  /etc/init.d/tomcat6 restart

  #Final Messages
  echo ---------------------------------------------------------
  echo Thanks for installing OSCAR & OpenMRS.
  echo This installation is suitable only for training purposes.
  echo ---------------------------------------------------------
  echo Access OSCAR at http://localhost:8001/Oscar10_12
  echo Login: oscardoc PASSWORD: mac2002 2ndPASSWORD: 1117
  echo ---------------------------------------------------------
  echo Access OpenMRS at http://localhost:8001/openmrs
  echo Login:admin password:Admin123
  echo ---------------------------------------------------------
  echo Access MySQL database at "mysql -u root -p"
  echo password: mysql
  echo ---------------------------------------------------------
  echo Please visit nuchange.ca for further info.

SCRIPT


Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box = "ubuntu/trusty32"
  config.vm.boot_timeout = 900
  config.ssh.insert_key = false


  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  #config.vm.box_url = "http://vagrant.boxes.lwndev.s3.amazonaws.com/quantal64.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine.
  config.vm.network "forwarded_port", guest: 80, host: 8000, auto_correct: true
  config.vm.network "forwarded_port", guest: 8080, host: 8001, auto_correct: true
  config.vm.network "forwarded_port", guest: 8787, host: 8002, auto_correct: true
  #config.vm.network "forwarded_port", guest: 8443, host: 8003, auto_correct: true

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  config.vm.synced_folder "code", "/home/vagrant/code", :create => true

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  #config.vm.network :private_network, ip: "192.168.40.10"

  config.vm.provider "virtualbox" do |v|
    v.name = "oscar"
    v.customize [
       "modifyvm", :id,
       "--name", "oscar",
       "--memory", "1536"]
    #v.gui = true
  end

 
  config.vm.provision :puppet do |puppet|
    puppet.module_path = "modules"
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
  end


  config.vm.provision "shell", inline: $script

end
