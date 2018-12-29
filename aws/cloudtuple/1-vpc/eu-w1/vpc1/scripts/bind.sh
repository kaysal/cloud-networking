#! /bin/bash
apt-get update
apt-get -y install dnsutils bind9 bind9-doc bind9utils awscli
echo "127.0.0.1 $HOSTNAME" >> /etc/hosts

export NAME_SERVER=127.0.0.1
export DOMAIN_NAME=cloudtuples.com
export DOMAIN_NAME_SEARCH=west1.cloudtuples.com

# resovconf()
cp /etc/resolv.conf /etc/resolv.conf.bak
cp /etc/dhcp/dhclient.conf /etc/dhcp/dhclient.conf.bak
cat <<EOF >> /etc/dhcp/dhclient.conf
supersede domain-name-servers $NAME_SERVER;
supersede domain-name $DOMAIN_NAME;
supersede domain-search $DOMAIN_NAME_SEARCH;
EOF

export LOCAL_FORWARDERS=172.16.0.2
export LOCAL_NAME_SERVER_IP=172.16.10.100
export LOCAL_ZONE=west1.cloudtuples.com
export LOCAL_ZONE_FILE=/etc/bind/db.west1.cloudtuples.com
export LOCAL_ZONE_INV=10.16.172.in-addr.arpa
export LOCAL_ZONE_INV_FILE=/etc/bind/db.west1.cloudtuples.com.inv
export GCP_DNS_RANGE=35.199.192.0/19
export GOOGLEAPIS_ZONE=googleapis.zone
export GOOGLEAPIS_ZONE_FILE=/etc/bind/db.googleapis.zone
export REMOTE_ZONE_GCP_APPLE_PROJECT=apple.cloudtuple.com
export REMOTE_ZONE_GCP_ORANGE_PROJECT=orange.cloudtuple.com
export REMOTE_ZONE_GCP_MANGO_PROJECT=mango.cloudtuple.com
export REMOTE_NS_GCP_APPLE_PROJECT='10.100.10.2;10.150.10.2;10.200.10.2;10.250.10.2'
export REMOTE_NS_GCP_ORANGE_PROJECT='10.200.20.3'
export REMOTE_NS_GCP_MANGO_PROJECT='10.200.30.3'
export REMOTE_ZONE_AWS_EAST1=east1.cloudtuples.com
export REMOTE_NS_AWS_EAST1=172.'18.11.51;172.18.10.200'

wget https://storage.googleapis.com/salawu-gcs/aws/bind9/named.conf.options.text
cp named.conf.options.text /etc/bind/named.conf.options
sed -i "s|\<GCP_DNS_RANGE\>|$GCP_DNS_RANGE|" /etc/bind/named.conf.options
sed -i "s|\<LOCAL_FORWARDERS\>|$LOCAL_FORWARDERS|" /etc/bind/named.conf.options
sed -i "s|\<GOOGLEAPIS_ZONE\>|$GOOGLEAPIS_ZONE|" /etc/bind/named.conf.options

wget https://storage.googleapis.com/salawu-gcs/aws/bind9/named.conf.local.text
cp named.conf.local.text /etc/bind/named.conf.local
sed -i "s|\<LOCAL_ZONE\>|$LOCAL_ZONE|" /etc/bind/named.conf.local
sed -i "s|\<LOCAL_ZONE_FILE\>|$LOCAL_ZONE_FILE|" /etc/bind/named.conf.local
sed -i "s|\<LOCAL_ZONE_INV\>|$LOCAL_ZONE_INV|" /etc/bind/named.conf.local
sed -i "s|\<LOCAL_ZONE_INV_FILE\>|$LOCAL_ZONE_INV_FILE|" /etc/bind/named.conf.local
sed -i "s|\<GOOGLEAPIS_ZONE\>|$GOOGLEAPIS_ZONE|" /etc/bind/named.conf.local
sed -i "s|\<GOOGLEAPIS_ZONE_FILE\>|$GOOGLEAPIS_ZONE_FILE|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_ZONE_GCP_APPLE_PROJECT\>|$REMOTE_ZONE_GCP_APPLE_PROJECT|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_ZONE_GCP_ORANGE_PROJECT\>|$REMOTE_ZONE_GCP_ORANGE_PROJECT|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_ZONE_GCP_MANGO_PROJECT\>|$REMOTE_ZONE_GCP_MANGO_PROJECT|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_NS_GCP_APPLE_PROJECT\>|$REMOTE_NS_GCP_APPLE_PROJECT|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_NS_GCP_ORANGE_PROJECT\>|$REMOTE_NS_GCP_ORANGE_PROJECT|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_NS_GCP_MANGO_PROJECT\>|$REMOTE_NS_GCP_MANGO_PROJECT|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_ZONE_AWS_EAST1\>|$REMOTE_ZONE_AWS_EAST1|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_NS_AWS_EAST1\>|$REMOTE_NS_AWS_EAST1|" /etc/bind/named.conf.local

wget https://storage.googleapis.com/salawu-gcs/aws/bind9/db.west1.cloudtuples.com.text
cp db.west1.cloudtuples.com.text $LOCAL_ZONE_FILE

wget https://storage.googleapis.com/salawu-gcs/aws/bind9/db.west1.cloudtuples.com.inv.text
cp db.west1.cloudtuples.com.inv.text $LOCAL_ZONE_INV_FILE

wget https://storage.googleapis.com/salawu-gcs/aws/bind9/db.googleapis.zone.text
cp db.googleapis.zone.text $GOOGLEAPIS_ZONE_FILE

service bind9 restart
reboot
