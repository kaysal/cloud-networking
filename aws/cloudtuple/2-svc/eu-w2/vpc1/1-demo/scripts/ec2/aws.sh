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

#pip install awscli
#aws configure
#aws ec2 describe-prefix-lists
