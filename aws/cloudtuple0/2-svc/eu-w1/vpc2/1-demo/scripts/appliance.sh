#! /bin/bash
yum -y update
yum -y install \
  traceroute \
  mtr \
  tcpdump \
  bind-utils \
  nmap \
  fping \
  awscli

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j DNAT --to 172.17.10.10:80
service network restart
