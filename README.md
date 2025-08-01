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
        Type=forking --> process that starts child processes
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

- Save the file 
- Use  systemctl daemon-reload whenever systemd file is changed
- systemclt start tomcat
- systemctl enable tomcat

# CODE BUILD AND DEPLOY
- Tomcat does not understand ur code so 
- we create a package
- that package is where we put the code 
- now this package is what out tomcat can read
- to perform the above task we use maven
- install all dependancy
- clone source code
##### There u will see application.properties
- file which our project will use to connect to backend services
- in this file changed the password to 123
-       /usr/local/maven3.9/bin/mvn install-> to take the source code 
-        and build it into the package using mvn
-       do ls u will target -> ls -> artefact(vprofile-v2.war) -> war is archive injava
-       ls /usr/local/tomcat/webapps/
##### In thAT US Will see ROOT remove that and copy ur artefact file

## BASH SCRIPTING : REMOTE COMMAND EXECUTION ##
- Executing commands on a machine from another machine :
        login to machine 1
        add machine 2 in /etc/hosts
        ping machine 2
        do ssh vagrant@machine2 inside m1 sudo
        now to use another user istead of vagrant u can add one user 
        m1->m2->sudo->useradd devops->passwd devops->add devops to sudos file->visudo -> devops ALL= (ALL) NOPASSWD=ALL
        now u can use ssh devops@web01 --> also run command without login inside web01 as ssh devops@web01 uptime
        everytime we do this it asks for passwd to avoid that we use key exchange :
 #### Key exchange :####
        ssh-keygen
        press enter until u get the key
        your identification.... is the private key --> key 
        your public key... is the public key --> lock 
        add key to the m2 machine and use key to use commands to use withou pass
- ssh-copy-id devops@m1
        this commnad will apply the lock to the vm m1now u can test ssh devops@web01 uptime

                                                                                                    

