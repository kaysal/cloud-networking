#!/bin/bash

# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update the package list and install

apt-get update
apt-get -y install google-cloud-sdk awscli \
apache2 apache2-utils \
fping tcpdump host dnsutils jq libxml2-utils

python3 python3-pip
pip3 install requests
pip3 install dnspython

wget -O /usr/local/bin/private_api.py https://storage.googleapis.com/salawu-gcs/gcp/networking/private_api.py
wget -O /usr/local/bin/private_api.sh https://storage.googleapis.com/salawu-gcs/gcp/networking/private_api.sh
chmod a+x /usr/local/bin/private_api.py
chmod a+x /usr/local/bin/private_api.sh

# script
touch /var/tmp/list.txt
cat <<EOF > /var/tmp/list.txt
server.onprem.lab
web80.spoke1.lab
EOF

touch /usr/local/bin/pinger
chmod a+x /usr/local/bin/pinger
cat <<EOF > /usr/local/bin/pinger
  fping -A -f /var/tmp/list.txt
  echo "curl ${ILB1_80} --> \$(curl -sS --connect-timeout 2 ${ILB1_80})"
  echo "curl ${ILB1_81} --> \$(curl -sS --connect-timeout 2 ${ILB1_81})"
  echo "curl ${ILB2_80} --> \$(curl -sS --connect-timeout 2 ${ILB2_80})"
  echo "curl ${ILB2_81} --> \$(curl -sS --connect-timeout 2 ${ILB2_81})"
EOF

COMPUTE=https://www.googleapis.com/compute/v1/projects
STORAGE=https://www.googleapis.com/storage/v1/b?project
touch /usr/local/bin/curlz
chmod a+x /usr/local/bin/curlz
cat <<EOF > /usr/local/bin/curlz
  echo ""
  echo "------ SPOKE 1 ------"
  echo ""
  curl -sS -X GET -H "Authorization:Bearer \$SPOKE1_TOKEN" \
  $STORAGE=${SPOKE1_PROJECT_ID} 2>&1
  curl -X GET -H "Authorization: Bearer \$SPOKE1_TOKEN" \
  https://storage.googleapis.com/${PREFIX}${SPOKE1_PROJECT_ID} | xmllint --format -
  echo ""
  echo "------ SPOKE 2 ------"
  echo ""
  curl -sS -X GET -H "Authorization:Bearer \$SPOKE2_TOKEN" \
  $STORAGE=${SPOKE2_PROJECT_ID} 2>&1
  echo ""
  curl -X GET -H "Authorization: Bearer \$SPOKE2_TOKEN" \
    https://storage.googleapis.com/${PREFIX}${SPOKE2_PROJECT_ID} | xmllint --format -
EOF

echo "127.0.0.1 $HOSTNAME" >> /etc/hosts

cp /etc/resolv.conf /etc/resolv.conf.bak
cp /etc/dhcp/dhclient.conf /etc/dhcp/dhclient.conf.bak
cat <<EOF >> /etc/dhcp/dhclient.conf
supersede domain-name-servers ${NAME_SERVER};
supersede domain-name ${DOMAIN_NAME};
supersede domain-search ${DOMAIN_NAME_SEARCH};
EOF

reboot
