#! /bin/bash
sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
apt-get update
apt-get install squid -y
cat <<EOF >>/etc/squid/whitelisted-domains.txt
.googleapis.com
# <faux-on-prem-svc-ip>
EOF
sudo service squid restart
