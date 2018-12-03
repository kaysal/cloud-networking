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
  fping \
  awscli

export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
apt-get update
apt-get -y install google-cloud-sdk

echo "127.0.0.1 $HOSTNAME" >> /etc/hosts

export NAME_SERVER=172.16.10.100
export DOMAIN_NAME=cloudtuples.com
export DOMAIN_NAME_SEARCH=west1.cloudtuples.com

cp /etc/resolv.conf /etc/resolv.conf.bak
cp /etc/dhcp/dhclient.conf /etc/dhcp/dhclient.conf.bak
cat <<EOF >> /etc/dhcp/dhclient.conf
supersede domain-name-servers $NAME_SERVER;
supersede domain-name $DOMAIN_NAME;
supersede domain-search $DOMAIN_NAME_SEARCH;
EOF

reboot
