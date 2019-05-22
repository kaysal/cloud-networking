#! /bin/bash
apt-get update
apt-get -y install \
  traceroute \
  mtr \
  tcpdump \
  iperf \
  whois \
  host \
  dnsutils \
  siege \
  nmap \
  fping \
  awscli

#pip install awscli
#aws configure
#aws ec2 describe-prefix-lists
