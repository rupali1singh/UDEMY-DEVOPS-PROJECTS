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


# GIT & GITHUB

> This is the standard and safe way to combine branches.

    Steps:

    ### Switch to main branch
    git checkout main

    ### Update main to latest
    git pull origin main

    ### Merge feature branch into main
    git merge feature-branch

    ### Push merged changes to GitHub
    git push origin main

# SYSTEM & TOMCAT : SERVICE MANAGEMENT
- install httpd on centos
- check the configuration using cat inside /usr/lib/systemd/system/httpd.servic
- There u will see three definitions --> Unit , Service, Install  --> ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND in Service is used for https status
- Now the package manager here dnf. APACHE TOMCAT can not be installed using thaT. Soooo...
- download using tar link from apache using wget and extract it
- java using dnf install java-17-openjdk -y
- Now inside the apache_folder/bin/ extarct there is startup.sh ---> script written to start tomcat
- To start tomcat do --> go inside apach --> do bin/startup.sh --> msg : tomcat staeted
- ps -ef |grep tomcat --> will get the tomacat processes
- Now we can use show ip addr to check in the browser 
- This is running because we used startup.sh, But we cannot use startup.sh Since we want tomcat to get enabled at boottime : If the OS  reboots tomcat will not start automatically so we need a scritpt for that