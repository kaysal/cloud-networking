#!/bin/bash
apt-get update
apt-get -y install traceroute mtr tcpdump iperf whois host dnsutils siege nmap

cd /opt
wget https://storage.googleapis.com/salawu-gcs/gcp/instances/wget.sh
