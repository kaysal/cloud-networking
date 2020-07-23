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
wget -O /usr/local/bin/tcp.sh https://storage.googleapis.com/salawu-gcs/gcp/networking/gcloud/tcp.sh
chmod a+x /usr/local/bin/private_api.py
chmod a+x /usr/local/bin/private_api.sh
chmod a+x /usr/local/bin/tcp.sh

echo "127.0.0.1 $HOSTNAME" >> /etc/hosts

touch /etc/netplan/99-custom-dns.yaml
cat <<EOF >> /etc/netplan/99-custom-dns.yaml
network:
  version: 2
  ethernets:
    eth0:
      nameservers:
        search: [${DOMAIN_NAME_SEARCH}]
        addresses: [${NAME_SERVER}]
      dhcp4-overrides:
        use-dns: false
EOF

reboot
