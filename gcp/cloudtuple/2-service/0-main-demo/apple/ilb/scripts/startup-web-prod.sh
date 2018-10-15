#! /bin/bash
apt-get update
apt-get install -y apache2 php traceroute dnsutils mtr
cd /var/www/html
rm index.html -f
rm index.php -f
wget https://storage.googleapis.com/salawu-gcs/gcp/instances/index.php
META_REGION_STRING=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/zone" -H "Metadata-Flavor: Google")
REGION=`echo "$META_REGION_STRING" | awk -F/ '{print $4}'`
IMAGE=https://storage.googleapis.com/salawu-gcs/gcp/images/prod.png
sed -i "s|region-here|$REGION|" index.php
sed -i "s|image-here|$IMAGE|" index.php
# To install the Stackdriver monitoring agent:
curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh
bash install-monitoring-agent.sh
# To install the Stackdriver logging agent:
curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
bash install-logging-agent.sh
