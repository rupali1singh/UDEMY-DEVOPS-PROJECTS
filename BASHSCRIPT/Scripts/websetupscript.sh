#!/bin/bash

#Installing dependencies
sudo yum install wget unzip httpd -y > /dev/null
echo
echo "#####################################################################"
echo "Start & enable service"
echo "#####################################################################"
sudo systemctl start httpd
sudo systemctl enable httpd
echo
echo "#####################################################################"
echo "Creating temp directory"
echo "#####################################################################"
mkdir -p /tmp/webfiles
cd /tmp/webfiles
echo
echo "#####################################################################"
echo "cloning the webfile from tooplate and copying to var"
echo  "#####################################################################"
wget https://www.tooplate.com/zip-templates/2137_barista_cafe.zip > /dev/null
unzip 2137_barista_cafe.zip > /dev/null
sudo cp -r 2137_barista_cafe/* /var/www/html/ > /dev/null
echo
echo "#####################################################################"
echo "Restarting the services"
echo "#####################################################################"
systemctl restart httpd

echo "#####################################################################"
echo "Clean Up"
echo "#####################################################################"
rm -rf /tmp/webfiles
