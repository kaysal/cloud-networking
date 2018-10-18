#! /bin/bash
apt-get update
apt-get -y install dnsutils bind9 bind9-doc bind9utils
echo "127.0.0.1 $HOSTNAME" >> /etc/hosts

export NAME_SERVER=127.0.0.1
export DOMAIN_NAME=cloudtuple.com
export DOMAIN_NAME_SEARCH=aws.cloudtuple.com

# resovconf()
cp /etc/resolv.conf /etc/resolv.conf.bak
cp /etc/dhcp/dhclient.conf /etc/dhcp/dhclient.conf.bak
cat <<EOF >> /etc/dhcp/dhclient.conf
supersede domain-name-servers $NAME_SERVER;
supersede domain-name $DOMAIN_NAME;
supersede domain-search $DOMAIN_NAME_SEARCH;
EOF

export GCP_DNS_RANGE=35.199.192.0/19
export LOCAL_FORWARDERS=172.18.0.2
export LOCAL_ZONE=aws.cloudtuple.com
export LOCAL_ZONE_FILE=/etc/bind/db.aws.cloudtuple.com
export LOCAL_ZONE_INV=10.18.172.in-addr.arpa
export LOCAL_ZONE_INV_FILE=/etc/bind/db.aws.cloudtuple.com.inv
export GOOGLEAPIS_ZONE=googleapis.zone
export GOOGLEAPIS_ZONE_FILE=/etc/bind/db.googleapis.zone
export LOCAL_NAME_SERVER_IP=172.18.10.100
export REMOTE_ZONE=gcp.cloudtuple.com
export REMOTE_NAME_SERVER_IP=10.200.10.4

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
sed -i "s|\<REMOTE_ZONE\>|$REMOTE_ZONE|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_NAME_SERVER_IP\>|$REMOTE_NAME_SERVER_IP|" /etc/bind/named.conf.local

wget https://storage.googleapis.com/salawu-gcs/aws/bind9/db.aws.cloudtuple.com.text
cp db.aws.cloudtuple.com.text $LOCAL_ZONE_FILE

wget https://storage.googleapis.com/salawu-gcs/aws/bind9/db.aws.cloudtuple.com.inv.text
cp db.aws.cloudtuple.com.inv.text $LOCAL_ZONE_INV_FILE

wget https://storage.googleapis.com/salawu-gcs/aws/bind9/db.googleapis.zone.text
cp db.googleapis.zone.text $GOOGLEAPIS_ZONE_FILE

service bind9 restart
reboot
