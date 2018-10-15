#!bin/bash

# cpanel 1
sudo su
lxc-attach -n cpanel1
#---
yum install -y curl screen
hostname cpanel1.cloudtuple.com
screen
cd /home && curl -o latest -L https://securedownloads.cpanel.net/latest && sh latest


# cpanel 2
sudo su
lxc-attach -n cpanel2
#---
yum install -y curl screen
hostname cpanel2.cloudtuple.com
screen
cd /home && curl -o latest -L https://securedownloads.cpanel.net/latest && sh latest
