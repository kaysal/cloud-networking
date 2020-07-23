#! /bin/bash

apt-get update
apt install -y tcpdump fping dnsutils jq libxml2-utils \
python3 python3-pip
pip3 install requests
pip3 install dnspython

wget -O /tmp/private_api.py https://storage.googleapis.com/salawu-gcs/gcp/networking/private_api.py
wget -O /tmp/private_api.sh https://storage.googleapis.com/salawu-gcs/gcp/networking/private_api.sh
chmod a+x /tmp/private_api.py
chmod a+x /tmp/private_api.sh
