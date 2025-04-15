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
- This is running because we used startup.sh, But we cannot use startup.sh Since we want tomcat to get enabled at boottime : If the OS  reboots tomcat will not start automatically so we need a scritpt for that so gonna kill that existing process of tomcaT
- Create a user --> useradd  useradd --home-dir /opt/tomcat --shell /sbin/nologin tomcat
-                                        DIR   for all bin files    for security purpose nologin

                🔹 useradd
                The base command to add a new user to the system.

                🔹 --home-dir /opt/tomcat
                This specifies the home directory for the new user.

                Instead of the default /home/tomcat, this user will have /opt/tomcat as its home directory.

                Useful when installing software (like Apache Tomcat) that lives in a different directory.

                🔹 --shell /sbin/nologin
                This sets the login shell to /sbin/nologin, which means:

                The user cannot log in interactively.

                It’s used for service accounts—users that exist to run software, not for real humans to log in.

                If someone tries to log in as tomcat, they'll get a message like "This account is currently not available."

                🔹 tomcat
                This is the username you're creating.

- chown -R tomcat.tomcat /opt/tomcat/  for making tomcat user the owner
- creating the service at this path --> vim /etc/systemd/system/tomcat.service

        [Unit]
        Description=Apache Tomcat Web Application Container
        After=network.target

        [Service]
        User=tomcat
        WorkingDirectory=/opt/tomcat
        Environment=JAVA_HOME=/usr/lib/jvm/jre
        Environment=CATALINA_HOME=/opt/tomcat
        Environment=CATALINA_BASE=/opt/tomcat
        ExecStart=/opt/tomcat/bin/startup.sh
        ExecStop=/opt/tomcat/bin/shutdown.sh
        Restart=on-failure





###### Description: A short description of the service—this will show up when you use systemctl status tomcat.

###### After=network.target: Ensures that the network is up and running before Tomcat starts. This is important because web apps need network access.

###### User=tomcat: Runs the service as the tomcat user (which has no login shell, as we set earlier). This enhances security by limiting access.

###### WorkingDirectory: The base directory for Tomcat—it’s where it will operate.

###### Environment=...: These set environment variables that Tomcat needs:

###### JAVA_HOME: Points to the Java runtime (necessary to run Tomcat).

###### CATALINA_HOME & CATALINA_BASE: Both usually point to the same Tomcat install dir.

###### ExecStart: The script used to start Tomcat.

###### ExecStop: The script used to stop Tomcat.

###### WantedBy=multi-user.target: Tells systemd to start this service at boot time, during the multi-user stage (standard for servers and network services). Non Gui mod of operating system (Complete OS STARTUP - GUI)


                                                                                                                      