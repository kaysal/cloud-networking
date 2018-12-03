#!/bin/vbash
#source /opt/vyatta/etc/functions/script-template

export LOCAL_IP=$(curl 169.254.169.254/latest/meta-data/local-ipv4)
export NAT_IP=$(curl 169.254.169.254/latest/meta-data/public-ipv4)
export PEER_IP=35.189.197.53
export IBGP_PEER_IP=172.16.0.100
export LOCAL_VTI_IP=169.254.100.5/30
export PEER_VTI_IP=169.254.100.6
export BGP_NETWORK1=172.16.10.0/24
export BGP_NETWORK2=172.16.11.0/24
export LOCAL_DEFAULT_ROUTER=172.16.1.1
export LOCAL_ASN=65010
export REMOTE_ASN=65000
export PSK=password123

configure

#! ---------------------------------------------------
#! IPsec ESP Configuration
#!
set vpn ipsec esp-group GCP compression 'disable'
set vpn ipsec esp-group GCP lifetime '3600'
set vpn ipsec esp-group GCP mode 'tunnel'
set vpn ipsec esp-group GCP pfs 'enable'
set vpn ipsec esp-group GCP proposal 1 encryption 'aes128'
set vpn ipsec esp-group GCP proposal 1 hash 'sha1'
#!
#! ---------------------------------------------------
#! IPsec IKE Configuration
#!
set vpn ipsec ike-group GCP lifetime '28800'
set vpn ipsec ike-group GCP proposal 1 dh-group '2'
set vpn ipsec ike-group GCP proposal 1 encryption 'aes128'
set vpn ipsec ike-group GCP proposal 1 hash 'sha1'
set vpn ipsec ike-group GCP dead-peer-detection action 'restart'
set vpn ipsec ike-group GCP dead-peer-detection interval '15'
set vpn ipsec ike-group GCP dead-peer-detection timeout '30'
#!
#! ---------------------------------------------------
#! IPsec Tunnel Configuration
#!
set vpn ipsec site-to-site peer $PEER_IP authentication id $NAT_IP
set vpn ipsec site-to-site peer $PEER_IP authentication mode 'pre-shared-secret'
set vpn ipsec site-to-site peer $PEER_IP authentication pre-shared-secret $PSK
set vpn ipsec site-to-site peer $PEER_IP description 'VPC tunnel 1'
set vpn ipsec site-to-site peer $PEER_IP ike-group 'GCP'
set vpn ipsec site-to-site peer $PEER_IP local-address $LOCAL_IP
set vpn ipsec site-to-site peer $PEER_IP vti bind 'vti0'
set vpn ipsec site-to-site peer $PEER_IP vti esp-group 'GCP'
#!
#! ---------------------------------------------------
#! Tunnel Interface Configuration
#!
set vpn ipsec ipsec-interfaces interface 'eth0'
set interfaces vti vti0 address $LOCAL_VTI_IP
set interfaces vti vti0 description 'VPC tunnel 1'
set interfaces vti vti0 mtu '1436'
#!
#!
#! ---------------------------------------------------
#! BGP Configuration
#!
set protocols bgp $LOCAL_ASN neighbor $IBGP_PEER_IP remote-as $LOCAL_ASN
set protocols bgp $LOCAL_ASN neighbor $PEER_VTI_IP remote-as $REMOTE_ASN
set protocols bgp $LOCAL_ASN neighbor $PEER_VTI_IP soft-reconfiguration 'inbound'
set protocols bgp $LOCAL_ASN neighbor $PEER_VTI_IP timers holdtime '30'
set protocols bgp $LOCAL_ASN neighbor $PEER_VTI_IP timers keepalive '10'
#set protocols bgp $LOCAL_ASN network $BGP_NETWORK1
#set protocols bgp $LOCAL_ASN network $BGP_NETWORK2
set protocols bgp $LOCAL_ASN parameters graceful-restart
#!
#! ---------------------------------------------------
#! Add local static routes
#!
set protocols static route $BGP_NETWORK1 next-hop $LOCAL_DEFAULT_ROUTER
set protocols static route $BGP_NETWORK2 next-hop $LOCAL_DEFAULT_ROUTER

set policy prefix-list GCP rule 10 action 'permit'
set policy prefix-list GCP rule 10 prefix $BGP_NETWORK1
set policy prefix-list GCP rule 20 action 'permit'
set policy prefix-list GCP rule 20 prefix $BGP_NETWORK2
set policy route-map GCP rule 10 action 'permit'
set policy route-map GCP rule 10 match ip address prefix-list 'GCP'
set policy route-map GCP rule 10 set metric 100
set protocols bgp 65010 redistribute static route-map GCP
set protocols bgp 65010 neighbor $PEER_VTI_IP route-map export 'GCP'

commit
save
exit
