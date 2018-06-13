#! /bin/bash
apt-get update
apt-get install squid -y
sed -i 's:#\(http_access allow localnet\):\1:' /etc/squid/squid.conf
sed -i 's:#\(http_access deny to_localhost\):\1:' /etc/squid/squid.conf
sed -i 's:#\(acl localnet src 10.0.0.0/8.*\):\1:' /etc/squid/squid.conf
sed -i 's:#\(acl localnet src 172.16.0.0/12.*\):\1:' /etc/squid/squid.conf
sed -i 's:#\(acl localnet src 192.168.0.0/16.*\):\1:' /etc/squid/squid.conf
sed -i 's:#\(acl localnet src fc00\:\:/7.*\):\1:' /etc/squid/squid.conf
sed -i 's:#\(acl localnet src fe80\:\:/10.*\):\1:' /etc/squid/squid.conf
# Prevent proxy access to metadata server
cat <<EOF >>/etc/squid/squid.conf
acl to_metadata dst 169.254.169.254
http_access deny to_metadata
EOF
service squid restart
