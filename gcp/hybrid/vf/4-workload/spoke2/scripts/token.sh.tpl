#! /bin/bash

apt-get update
apt install -y apache2 \


systemctl restart apache2

touch /tmp/pinger
chmod a+x /tmp/pinger
cat <<EOF > /tmp/pinger
  fping -A -f /tmp/list.txt
  echo "curl ${SPOKE_8080} --> \$(curl -sS --connect-timeout 2 ${SPOKE_8080})"
  echo "curl ${SPOKE_8081} --> \$(curl -sS --connect-timeout 2 ${SPOKE_8081})"
EOF

wget -O /tmp/private_api.py https://storage.googleapis.com/salawu-gcs/gcp/networking/private_api.py
wget -O /tmp/private_api.sh https://storage.googleapis.com/salawu-gcs/gcp/networking/private_api.sh
chmod a+x /tmp/private_api.py
chmod a+x /tmp/private_api.sh

touch /usr/local/bin/tokenz
chmod a+x /usr/local/bin/tokenz
cat <<EOF > /usr/local/bin/tokenz
i=0
while [ \$i -lt 2 ]; do
  ACCESS_TOKEN=$(gcloud auth application-default print-access-token)
  echo $ACCESS_TOKEN > /var/www/html/index.html
  let i=i+1
  sleep 5
done
EOF

echo "*/5 * * * * /usr/local/bin/tokenz 2>&1 > /dev/null" > /tmp/crontab.txt
crontab /tmp/crontab.txt
