#!/bin/bash -xe
apt-get update
apt-get -y install \
  awscli \
  traceroute \
  mtr \
  tcpdump \
  iperf \
  whois \
  host \
  dnsutils \
  siege \
  apache2 php

echo "127.0.0.1 $HOSTNAME" >> /etc/hosts

#aws configure
