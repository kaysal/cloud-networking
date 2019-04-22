#!/bin/bash
#source /opt/vyatta/etc/functions/script-template

#! Router IP Addresses
export LOCAL_IP=$(curl 169.254.169.254/latest/meta-data/local-ipv4)
export NAT_IP=$(curl 169.254.169.254/latest/meta-data/public-ipv4)

#! gcp 'vpc' vpc
export PEER_IP=34.76.208.118
export LOCAL_VTI_IP=169.254.100.1/30
export PEER_VTI_IP=169.254.100.2

#gcp 'untrust' vpc
export PEER_IP2=34.76.52.80
export LOCAL_VTI_IP2=169.254.100.9/30
export PEER_VTI_IP2=169.254.100.10

#! Local AWS Subnets and parameters
export LOCAL_NETWORK=172.16.0.0/16
export LOCAL_DEFAULT_ROUTER=172.16.0.1
export LOCAL_ASN=65010
export REMOTE_ASN=65000
export PSK=password123

configure

#! ---------------------------------------------------
#! IPsec ESP Configuration
#! ---------------------------------------------------
#! gcp 'vpc' vpc
set vpn ipsec esp-group GCP compression 'disable'
set vpn ipsec esp-group GCP lifetime '3600'
set vpn ipsec esp-group GCP mode 'tunnel'
set vpn ipsec esp-group GCP pfs 'enable'
set vpn ipsec esp-group GCP proposal 1 encryption 'aes128'
set vpn ipsec esp-group GCP proposal 1 hash 'sha1'
#! gcp 'untrust' vpc
set vpn ipsec esp-group UNTRUST compression 'disable'
set vpn ipsec esp-group UNTRUST lifetime '3600'
set vpn ipsec esp-group UNTRUST mode 'tunnel'
set vpn ipsec esp-group UNTRUST pfs 'enable'
set vpn ipsec esp-group UNTRUST proposal 1 encryption 'aes128'
set vpn ipsec esp-group UNTRUST proposal 1 hash 'sha1'
#!
#! ---------------------------------------------------
#! IPsec IKE Configuration
#! ---------------------------------------------------
#! gcp 'vpc' vpc
set vpn ipsec ike-group GCP lifetime '28800'
set vpn ipsec ike-group GCP proposal 1 dh-group '2'
set vpn ipsec ike-group GCP proposal 1 encryption 'aes128'
set vpn ipsec ike-group GCP proposal 1 hash 'sha1'
set vpn ipsec ike-group GCP dead-peer-detection action 'restart'
set vpn ipsec ike-group GCP dead-peer-detection interval '15'
set vpn ipsec ike-group GCP dead-peer-detection timeout '30'
#!
#! gcp 'untrust' vpc
set vpn ipsec ike-group UNTRUST lifetime '28800'
set vpn ipsec ike-group UNTRUST proposal 1 dh-group '2'
set vpn ipsec ike-group UNTRUST proposal 1 encryption 'aes128'
set vpn ipsec ike-group UNTRUST proposal 1 hash 'sha1'
set vpn ipsec ike-group UNTRUST dead-peer-detection action 'restart'
set vpn ipsec ike-group UNTRUST dead-peer-detection interval '15'
set vpn ipsec ike-group UNTRUST dead-peer-detection timeout '30'
#!
#! ---------------------------------------------------
#! IPsec Tunnel Configuration
#! ---------------------------------------------------
#! gcp 'vpc' vpc
set vpn ipsec site-to-site peer $PEER_IP authentication id $NAT_IP
set vpn ipsec site-to-site peer $PEER_IP authentication mode 'pre-shared-secret'
set vpn ipsec site-to-site peer $PEER_IP authentication pre-shared-secret $PSK
set vpn ipsec site-to-site peer $PEER_IP description 'VPC tunnel 1'
set vpn ipsec site-to-site peer $PEER_IP ike-group 'GCP'
set vpn ipsec site-to-site peer $PEER_IP local-address $LOCAL_IP
set vpn ipsec site-to-site peer $PEER_IP vti bind 'vti0'
set vpn ipsec site-to-site peer $PEER_IP vti esp-group 'GCP'
#!
#! gcp 'untrust' vpc
set vpn ipsec site-to-site peer $PEER_IP2 authentication id $NAT_IP
set vpn ipsec site-to-site peer $PEER_IP2 authentication mode 'pre-shared-secret'
set vpn ipsec site-to-site peer $PEER_IP2 authentication pre-shared-secret $PSK
set vpn ipsec site-to-site peer $PEER_IP2 description 'VPC tunnel 2'
set vpn ipsec site-to-site peer $PEER_IP2 ike-group 'UNTRUST'
set vpn ipsec site-to-site peer $PEER_IP2 local-address $LOCAL_IP
set vpn ipsec site-to-site peer $PEER_IP2 vti bind 'vti1'
set vpn ipsec site-to-site peer $PEER_IP2 vti esp-group 'UNTRUST'
#!
#! ---------------------------------------------------
#! Tunnel Interface Configuration
#! ---------------------------------------------------
#! gcp 'vpc' vpc
set vpn ipsec ipsec-interfaces interface 'eth0'
set interfaces vti vti0 address $LOCAL_VTI_IP
set interfaces vti vti0 description 'VPC tunnel 1'
set interfaces vti vti0 mtu '1436'
#!
#! gcp 'untrust' vpc
set vpn ipsec ipsec-interfaces interface 'eth0'
set interfaces vti vti1 address $LOCAL_VTI_IP2
set interfaces vti vti1 description 'VPC tunnel 2'
set interfaces vti vti1 mtu '1436'
#!
#! ---------------------------------------------------
#! BGP Configuration
#! ---------------------------------------------------
#! gcp 'vpc' vpc
set protocols bgp $LOCAL_ASN neighbor $PEER_VTI_IP remote-as $REMOTE_ASN
set protocols bgp $LOCAL_ASN neighbor $PEER_VTI_IP soft-reconfiguration 'inbound'
set protocols bgp $LOCAL_ASN neighbor $PEER_VTI_IP timers holdtime '30'
set protocols bgp $LOCAL_ASN neighbor $PEER_VTI_IP timers keepalive '10'
set protocols bgp $LOCAL_ASN parameters graceful-restart
#!
#! gcp 'untrust' vpc
set protocols bgp $LOCAL_ASN neighbor $PEER_VTI_IP2 remote-as $REMOTE_ASN
set protocols bgp $LOCAL_ASN neighbor $PEER_VTI_IP2 soft-reconfiguration 'inbound'
set protocols bgp $LOCAL_ASN neighbor $PEER_VTI_IP2 timers holdtime '30'
set protocols bgp $LOCAL_ASN neighbor $PEER_VTI_IP2 timers keepalive '10'
#!
#! ---------------------------------------------------
#! Add local static routes
#! ---------------------------------------------------
set protocols static route $LOCAL_NETWORK next-hop $LOCAL_DEFAULT_ROUTER
#! ---------------------------------------------------
#! Add local static routes
#! ---------------------------------------------------
#! gcp 'vpc' vpc
set policy prefix-list GCP rule 10 action 'permit'
set policy prefix-list GCP rule 10 prefix $LOCAL_NETWORK
set policy route-map GCP rule 10 action 'permit'
set policy route-map GCP rule 10 match ip address prefix-list 'GCP'
set policy route-map GCP rule 10 set metric 100
set protocols bgp 65010 redistribute static route-map GCP
set protocols bgp 65010 neighbor $PEER_VTI_IP route-map export 'GCP'
#!
#! gcp 'untrust' vpc
set policy prefix-list UNTRUST rule 10 action 'permit'
set policy prefix-list UNTRUST rule 10 prefix $LOCAL_NETWORK
set policy route-map UNTRUST rule 10 action 'permit'
set policy route-map UNTRUST rule 10 match ip address prefix-list 'UNTRUST'
set policy route-map UNTRUST rule 10 set metric 100
set protocols bgp 65010 redistribute static route-map UNTRUST
set protocols bgp 65010 neighbor $PEER_VTI_IP2 route-map export 'UNTRUST'
#!
commit
save
exit
