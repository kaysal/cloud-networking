#! /bin/bash
apt-get update
apt-get -y install dnsutils bind9 bind9-doc bind9utils awscli
echo "127.0.0.1 $HOSTNAME" >> /etc/hosts

# resovconf()
cp /etc/resolv.conf /etc/resolv.conf.bak
cp /etc/dhcp/dhclient.conf /etc/dhcp/dhclient.conf.bak
cat <<EOF >> /etc/dhcp/dhclient.conf
supersede domain-name-servers ${NAME_SERVER};
supersede domain-name ${DOMAIN_NAME};
supersede domain-search ${DOMAIN_NAME_SEARCH};
EOF

wget https://storage.googleapis.com/salawu-gcs/aws/bind9/named.conf.options.text
cp named.conf.options.text /etc/bind/named.conf.options
sed -i "s|\<GCP_DNS_RANGE\>|${GCP_DNS_RANGE}|" /etc/bind/named.conf.options
sed -i "s|\<LOCAL_FORWARDERS\>|${LOCAL_FORWARDERS}|" /etc/bind/named.conf.options
sed -i "s|\<GOOGLEAPIS_ZONE\>|${GOOGLEAPIS_ZONE}|" /etc/bind/named.conf.options

wget https://storage.googleapis.com/salawu-gcs/aws/bind9/named.conf.local.text
cp named.conf.local.text /etc/bind/named.conf.local
sed -i "s|\<LOCAL_ZONE\>|${LOCAL_ZONE}|" /etc/bind/named.conf.local
sed -i "s|\<LOCAL_ZONE_FILE\>|${LOCAL_ZONE_FILE}|" /etc/bind/named.conf.local
sed -i "s|\<LOCAL_ZONE_INV\>|${LOCAL_ZONE_INV}|" /etc/bind/named.conf.local
sed -i "s|\<LOCAL_ZONE_INV_FILE\>|${LOCAL_ZONE_INV_FILE}|" /etc/bind/named.conf.local
sed -i "s|\<GOOGLEAPIS_ZONE\>|${GOOGLEAPIS_ZONE}|" /etc/bind/named.conf.local
sed -i "s|\<GOOGLEAPIS_ZONE_FILE\>|${GOOGLEAPIS_ZONE_FILE}|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_ZONE_GCP_HOST_PROJECT\>|${REMOTE_ZONE_GCP_HOST_PROJECT}|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_ZONE_GCP_APPLE_PROJECT\>|${REMOTE_ZONE_GCP_APPLE_PROJECT}|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_ZONE_GCP_GKE_PROJECT\>|${REMOTE_ZONE_GCP_GKE_PROJECT}|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_ZONE_GCP_ORANGE_PROJECT\>|${REMOTE_ZONE_GCP_ORANGE_PROJECT}|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_ZONE_GCP_MANGO_PROJECT\>|${REMOTE_ZONE_GCP_MANGO_PROJECT}|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_NS_GCP_HOST_PROJECT\>|${REMOTE_NS_GCP_HOST_PROJECT}|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_NS_GCP_ORANGE_PROJECT\>|${REMOTE_NS_GCP_ORANGE_PROJECT}|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_NS_GCP_MANGO_PROJECT\>|${REMOTE_NS_GCP_MANGO_PROJECT}|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_ZONE_AWS_EAST1\>|${REMOTE_ZONE_AWS_EAST1}|" /etc/bind/named.conf.local
sed -i "s|\<REMOTE_NS_AWS_EAST1\>|${REMOTE_NS_AWS_EAST1}|" /etc/bind/named.conf.local

wget https://storage.googleapis.com/salawu-gcs/aws/bind9/db.west1.cloudtuples.com.text
cp db.west1.cloudtuples.com.text ${LOCAL_ZONE_FILE}

wget https://storage.googleapis.com/salawu-gcs/aws/bind9/db.west1.cloudtuples.com.inv.text
cp db.west1.cloudtuples.com.inv.text ${LOCAL_ZONE_INV_FILE}

wget https://storage.googleapis.com/salawu-gcs/aws/bind9/db.googleapis.zone.text
cp db.googleapis.zone.text ${GOOGLEAPIS_ZONE_FILE}

service bind9 restart
reboot
