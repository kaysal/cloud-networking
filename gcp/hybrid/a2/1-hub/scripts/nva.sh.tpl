#! /bin/bash

apt update
apt install -y tcpdump fping dnsutils libxml2-utils apache2-utils

sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
sysctl -w net.ipv4.conf.all.forwarding=1

iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT

iptables -A PREROUTING -t nat -i eth0 -d ${ILB_80} -p tcp --dport 8080 -j DNAT --to ${SPOKE_80}:80
iptables -A PREROUTING -t nat -i eth0 -d ${ILB_81} -p tcp --dport 8081 -j DNAT --to ${SPOKE_81}:80

#iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source ${ETH0}
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source ${ETH0}

iptables -t nat -A POSTROUTING -o eth1 -j SNAT --to-source ${ETH1}
iptables -t nat -A POSTROUTING -o eth1 -j SNAT --to-source ${ETH1}

# routing for eth1
ifconfig eth1 ${ETH1} netmask 255.255.255.255 broadcast ${ETH1} mtu 1430
echo "1 rt1" | sudo tee -a /etc/iproute2/rt_tables
ip route add ${DGW1} src ${ETH1} dev eth1 table rt1
ip route add default via ${DGW1} dev eth1 table rt1
ip rule add to ${ETH1}/32 table rt1
ip rule add from ${ETH1}/32 table rt1
ip rule add to ${SPOKE} table rt1

# script
touch /tmp/list.txt
cat <<EOF > /tmp/list.txt
172.16.2.10
10.5.1.80
10.5.1.81
10.5.2.80
10.5.2.81
EOF

touch /tmp/pinger
chmod a+x /tmp/pinger
cat <<EOF > /tmp/pinger
  fping -A -f /tmp/list.txt
  echo "curl ${SPOKE_80} --> \$(curl -sS --connect-timeout 2 ${SPOKE_80})"
  echo "curl ${SPOKE_81} --> \$(curl -sS --connect-timeout 2 ${SPOKE_81})"
EOF
