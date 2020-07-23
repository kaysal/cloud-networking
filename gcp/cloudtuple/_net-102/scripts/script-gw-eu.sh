#! /bin/bash
sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
apt-get update
apt-get install squid -y
cat <<EOF >>/etc/squid/whitelisted-domains.txt
.googleapis.com
# <faux-on-prem-svc-ip>
EOF
sed -i 's:#\(acl localnet src 10.0.0.0/8.*\):\1:' /etc/squid/squid.conf
sed -i 's:#\(acl localnet src 172.16.0.0/12.*\):\1:' /etc/squid/squid.conf
sed -i 's:#\(acl localnet src 192.168.0.0/16.*\):\1:' /etc/squid/squid.conf
sed -i 's:#\(acl localnet src fc00\:\:/7.*\):\1:' /etc/squid/squid.conf
sed -i 's:#\(acl localnet src fe80\:\:/10.*\):\1:' /etc/squid/squid.conf
sed -i 's:\(acl Safe_ports port 21*\):#\1:' /etc/squid/squid.conf
sed -i 's:\(acl Safe_ports port 70*\):#\1:' /etc/squid/squid.conf
sed -i 's:\(acl Safe_ports port 210*\):#\1:' /etc/squid/squid.conf
sed -i 's:\(acl Safe_ports port 1025-65535*\):#\1:' /etc/squid/squid.conf
sed -i 's:\(acl Safe_ports port 280*\):#\1:' /etc/squid/squid.conf
sed -i 's:\(acl Safe_ports port 488*\):#\1:' /etc/squid/squid.conf
sed -i 's:\(acl Safe_ports port 591*\):#\1:' /etc/squid/squid.conf
sed -i 's:\(acl Safe_ports port 777*\):#\1:' /etc/squid/squid.conf
sed -i 's:\(http_access allow localhost manager\):#\1:' /etc/squid/squid.conf
sed -i 's:\(http_access deny manager\):#\1:' /etc/squid/squid.conf
sed -i 's:#\(http_access allow localnet\):\1:' /etc/squid/squid.conf
cat <<EOF >>/etc/squid/squid.conf
acl nw102-approved dstdomain "/etc/squid/whitelisted-domains.txt"
http_access allow nw102-approved
EOF
service squid start
