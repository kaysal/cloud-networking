#! /bin/bash
apt-get update
apt-get install -y php libapache2-mod-php php-mcrypt php-mysql traceroute
cd /var/www/html
rm index.html -f
rm index.php -f
wget https://storage.googleapis.com/startup-scripts-cns/rsync/instances/index.php
META_REGION_STRING=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/zone" -H "Metadata-Flavor: Google")
REGION=`echo "$META_REGION_STRING" | awk -F/ '{print $4}'`
sed -i "s|region-here|$REGION|" index.php

cd /opt
wget https://storage.googleapis.com/salawu-gcs/gcp/instances/wget.sh
