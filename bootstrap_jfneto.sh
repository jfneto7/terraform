#!/bin/bash 
yum install httpd git -y
git clone https://github.com/jfneto7/web.git /var/www/html/
echo $HOSTNAME >> /var/www/html/status.html
systemctl enable httpd
systemctl restart httpd
