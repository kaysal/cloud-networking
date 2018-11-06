#! /bin/bash
yum -y update
yum -y install \
  traceroute \
  mtr \
  tcpdump \
  bind-utils \
  nmap \
  fping

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
service network restart
