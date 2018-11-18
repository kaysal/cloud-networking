#! /bin/bash
apt-get update
apt-get install -y apache2 php stress
cd /var/www/html
rm index.html -f
rm index.php -f
wget https://storage.googleapis.com/salawu-gcs/aws/instances/index.php
AMI_ID=$(curl "http://169.254.169.254/latest/meta-data/ami-id")
AZ=$(curl "http://169.254.169.254/latest/meta-data/placement/availability-zone")
INSTANCE_ID=$(curl "http://169.254.169.254/latest/meta-data/instance-id")
INSTANCE_TYPE=$(curl "http://169.254.169.254/latest/meta-data/instance-type")
INTERNAL_DNS=$(curl "http://169.254.169.254/latest/meta-data/local-hostname")
MAC=$(curl "http://169.254.169.254/latest/meta-data/mac")
SECURITY_GROUPS=$(curl "http://169.254.169.254/latest/meta-data/security-groups")
PROFILE=$(curl "http://169.254.169.254/latest/meta-data/profile")

REGION=`echo "$META_REGION_STRING" | awk -F/ '{print $4}'`
IMAGE=https://storage.googleapis.com/salawu-gcs/aws/images/aws.png
sed -i "s|image-here|$IMAGE|" index.php
sed -i "s|zone-here|$AZ|" index.php
sed -i "s|ami-here|$AMI_ID|" index.php
sed -i "s|instanceid-here|$INSTANCE_ID|" index.php
sed -i "s|instancetype-here|$INSTANCE_TYPE|" index.php
sed -i "s|internaldns-here|$INTERNAL_DNS|" index.php
sed -i "s|macaddr-here|$MAC|" index.php
sed -i "s|secgrp-here|$SECURITY_GROUPS|" index.php
sed -i "s|profile-here|$PROFILE|" index.php
