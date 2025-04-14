## VAGARNT TOOL SETUP FOR USING VMS MANUALLY
### VAGRANT 
 A tool which manages vms lifecycle
How to use this box with Vagrant
#### Step 1
- Option 1: Create a Vagrantfile and initiate the box

        vagrant init eurolinux-vagrant/centos-stream-9 --box-version 9.0.48 

- Option 2: Open the Vagrantfile and replace the contents with the following

        Vagrant.configure("2") do |config|
        config.vm.box = "eurolinux-vagrant/centos-stream-9"
        config.vm.box_version = "9.0.48"
end

#### Step 2
        Bring up your virtual machine

        vagrant up

# VAGRANT VM PROVISIONING 

- for provisioning/bootstraping changes to be made in vagrant config file : uncomment 
        
        config.vm.provision "shell", inline: <<-SHELL
        apt-get update
        apt-get install -y apache2
        SHEL

- do vagrant reload
- You can not provision an existing vm but --provision can be used for force provisioning
