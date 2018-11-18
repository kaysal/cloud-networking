#!/bin/bash

configure
! ---------------------------------------------------
! IPsec ESP Configuration
!
set vpn ipsec esp-group GCP compression 'disable'
set vpn ipsec esp-group GCP lifetime '3600'
set vpn ipsec esp-group GCP mode 'tunnel'
set vpn ipsec esp-group GCP pfs 'enable'
set vpn ipsec esp-group GCP proposal 1 encryption 'aes128'
set vpn ipsec esp-group GCP proposal 1 hash 'sha1'
!
! ---------------------------------------------------
! IPsec IKE Configuration
!
set vpn ipsec ike-group GCP lifetime '28800'
set vpn ipsec ike-group GCP proposal 1 dh-group '2'
set vpn ipsec ike-group GCP proposal 1 encryption 'aes128'
set vpn ipsec ike-group GCP proposal 1 hash 'sha1'
set vpn ipsec ike-group GCP dead-peer-detection action 'restart'
set vpn ipsec ike-group GCP dead-peer-detection interval '15'
set vpn ipsec ike-group GCP dead-peer-detection timeout '30'
!
! ---------------------------------------------------
! IPsec Tunnel Configuration
!
set vpn ipsec site-to-site peer 104.199.107.232 authentication id '18.203.214.197'
set vpn ipsec site-to-site peer 104.199.107.232 authentication mode 'pre-shared-secret'
set vpn ipsec site-to-site peer 104.199.107.232 authentication pre-shared-secret 'password123'
set vpn ipsec site-to-site peer 104.199.107.232 description 'VPC tunnel 1'
set vpn ipsec site-to-site peer 104.199.107.232 ike-group 'GCP'
set vpn ipsec site-to-site peer 104.199.107.232 local-address '172.16.0.100'
set vpn ipsec site-to-site peer 104.199.107.232 vti bind 'vti0'
set vpn ipsec site-to-site peer 104.199.107.232 vti esp-group 'GCP'
!
! ---------------------------------------------------
! Tunnel Interface Configuration
!
set vpn ipsec ipsec-interfaces interface 'eth0'
set interfaces vti vti0 address '169.254.100.1/30'
set interfaces vti vti0 description 'VPC tunnel 1'
set interfaces vti vti0 mtu '1436'
!
!
! ---------------------------------------------------
! BGP Configuration
!
set protocols bgp 65010 neighbor 169.254.100.2 remote-as '65000'
set protocols bgp 65010 neighbor 169.254.100.2 soft-reconfiguration 'inbound'
set protocols bgp 65010 neighbor 169.254.100.2 timers holdtime '30'
set protocols bgp 65010 neighbor 169.254.100.2 timers keepalive '10'
set protocols bgp 65010 network 172.16.10.0/24
set protocols bgp 65010 network 172.16.11.0/24
set protocols bgp 65010 parameters graceful-restart
!
! ---------------------------------------------------
! Add local static routes
!
set protocols static route 172.16.10.0/24 next-hop 172.16.0.1
set protocols static route 172.16.11.0/24 next-hop 172.16.0.1
commit
save
exit
