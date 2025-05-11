#!/bin/bash

echo "##############################################################"
date
#ls /var/run/httpd/httpd.pid &> /dev/null

if [ -f /var/run/httpd/httpd.pid ]
then
        echo "Httpd process is running"
else
        echo "httpd process is not running"
        echo "Starting Httpd process"
        systemctl start httpd
        if [ $? -eq 0 ]
        then
            echo "Process started successfully"
        else
            echo "Process strating failed, contact the admin"
        fi
fi
echo "##############################################################"
