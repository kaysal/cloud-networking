#!/bin/bash
apt-get update
apt-get install -y tcpdump

echo 1 > /proc/sys/net/ipv4/ip_forward

E0_IP=$(ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
E1_IP=$(ip -o -4 addr list eth1 | awk '{print $4}' | cut -d/ -f1)
E2_IP=$(ip -o -4 addr list eth2 | awk '{print $4}' | cut -d/ -f1)

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

iptables -t nat -A PREROUTING -i eth0 -p tcp -d $E0_IP --dport 80 -j DNAT --to 10.0.1.10:80
iptables -t nat -A POSTROUTING -o eth1 -p tcp -d 10.0.1.10 --dport 80 -j SNAT --to $E1_IP

iptables -t nat -A PREROUTING -i eth0 -p tcp -d $E0_IP --dport 8080 -j DNAT --to 10.0.2.10:80
iptables -t nat -A POSTROUTING -o eth2 -p tcp -d 10.0.2.10 --dport 80 -j SNAT --to $E2_IP

sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE

iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp -d $E0_IP --dport 22 -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -s 169.254.169.254 -j ACCEPT

iptables -A FORWARD -i eth+ -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth1 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A FORWARD -i eth2 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A FORWARD -i eth0 -o eth1 -p tcp -m multiport --dports 80,443 -d 10.0.1.10 -j ACCEPT
iptables -A FORWARD -i eth0 -o eth2 -p tcp -m multiport --dports 80,443 -d 10.0.2.10 -j ACCEPT
iptables -A FORWARD -i eth+ -p icmp -j ACCEPT

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
