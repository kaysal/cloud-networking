#! /bin/bash
apt-get update
apt-get install -y apache2 php
cd /var/www/html
rm index.html -f
rm index.php -f
wget https://storage.googleapis.com/startup-scripts-cns/rsync/instances/index.php
wget https://storage.googleapis.com/startup-scripts-cns/rsync/networking/google-cloud-netblocks.sh
META_REGION_STRING=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/zone" -H "Metadata-Flavor: Google")
REGION=`echo "$META_REGION_STRING" | awk -F/ '{print $4}'`
sed -i "s|region-here|$REGION|" index.php
apt-get -y install traceroute mtr tcpdump iperf whois host dnsutils siege nmap

cd /opt
wget https://storage.googleapis.com/salawu-gcs/gcp/instances/wget.sh
