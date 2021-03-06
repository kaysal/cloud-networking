#! /bin/bash
apt-get update
apt-get -y install \
  traceroute \
  mtr \
  tcpdump \
  iperf \
  whois \
  host \
  dnsutils \
  siege \
  nmap \
  fping
cat <<EOF > ~/regions.txt
asia-east1-taiwan
asia-northeast1-tokyo
asia-south1-mumbai
asia-southeast1-singapore
australia-southeast1-sydney
europe-north1-finland
europe-west1-belgium
europe-west2-london
europe-west3-frankfurt
europe-west4-netherlands
northamerica-northeast1-montreal
southamerica-east1-sao-paulo
us-central1-iowa
us-east1-south-carolina
us-east4-n-virginia
us-west1-oregon
us-west2-los-angeles
EOF

cat <<EOF > ~/fpinger.sh
#!/bin/sh
fping -c 1 $(cat regions.txt)
EOF

chmod +x fpinger.sh

#fping -s -g 35.199.192.1 35.199.223.254 -r 1
