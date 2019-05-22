#! /bin/bash
apt-get update
apt-get -y install awscli traceroute mtr tcpdump iperf whois host dnsutils siege apache2 php

echo "127.0.0.1 $HOSTNAME" >> /etc/hosts

cd /var/www/html
rm index.html -f
rm index.php -f
wget https://storage.googleapis.com/salawu-gcs/aws/instances/index.php
cp index.php server.php
AMI_ID=$(curl "http://169.254.169.254/latest/meta-data/ami-id")
AZ=$(curl "http://169.254.169.254/latest/meta-data/placement/availability-zone")
INSTANCE_ID=$(curl "http://169.254.169.254/latest/meta-data/instance-id")
INSTANCE_TYPE=$(curl "http://169.254.169.254/latest/meta-data/instance-type")
INTERNAL_DNS=$(curl "http://169.254.169.254/latest/meta-data/local-hostname")
MAC=$(curl "http://169.254.169.254/latest/meta-data/mac")
SECURITY_GROUPS=$(curl "http://169.254.169.254/latest/meta-data/security-groups")
PROFILE=$(curl "http://169.254.169.254/latest/meta-data/profile")

IMAGE=https://cdn.cloudtuples.com/awsLogo.png
sed -i "s|image-here|$IMAGE|" server.php
sed -i "s|zone-here|$AZ|" server.php
sed -i "s|ami-here|$AMI_ID|" server.php
sed -i "s|instanceid-here|$INSTANCE_ID|" server.php
sed -i "s|instancetype-here|$INSTANCE_TYPE|" server.php
sed -i "s|internaldns-here|$INTERNAL_DNS|" server.php
sed -i "s|macaddr-here|$MAC|" server.php
sed -i "s|secgrp-here|$SECURITY_GROUPS|" server.php
sed -i "s|profile-here|$PROFILE|" server.php

#aws configure
