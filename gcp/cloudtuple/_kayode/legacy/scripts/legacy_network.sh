#! /bin/bash

# Legacy Network and Firewall
#===========================
export REGION=europe-west1
export ZONE=europe-west1-c
export PROJECT=kayode-209520
export NETWORK=legacy-network

gcloud config set project ${PROJECT}

gcloud compute networks create ${NETWORK} \
      --subnet-mode legacy \
      --range 10.10.20.0/24

gcloud compute firewall-rules create allow-all-legacy \
      --network ${NETWORK} \
      --allow tcp,udp,icmp

# Legacy Network instances
#===========================
gcloud compute instances create legacy-www-0 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --network ${NETWORK} \
    --zone ${ZONE} \
    --metadata startup-script="#! /bin/bash
      apt-get update
      apt-get install apache2 -y
      echo legacy-www-0 | sudo tee /var/www/html/index.html
      service apache2 restart
      EOF"

gcloud compute instances create legacy-www-1 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --network ${NETWORK} \
    --zone ${ZONE} \
    --metadata startup-script="#! /bin/bash
      apt-get update
      apt-get install apache2 -y
      echo legacy-www-1 | sudo tee /var/www/html/index.html
      service apache2 restart
      EOF"


# target pool already created with terrform script attached
#===========================
gcloud compute target-pools add-instances www-pool \
    --instances legacy-www-0,legacy-www-1 \
    --instances-zone ${ZONE}


# Create vpn tunnel to vpc network
# Corresponding vpc tunnel already created with TF
#===========================

# GW_IP_NAME already created in terraform
export GW_IP_NAME=nlb-legacy-vpn-gw
export VPN_GW_NAME=legacy-vpn-gateway
export ROUTER_NAME=legacy-cloud-router
export PEER_IP=35.240.47.112
export PEER_BGP_IP=169.254.169.1
export LOCAL_BGP_IP=169.254.169.2
export LOCAL_ASN=65010
export PEER_ASN=65000
export SECRET=password123
export INTERFACE_NAME=to-vpc-network
export TUNNEL_NAME=to-vpc-network
export PEER_NAME=vpc-cloud-router

gcloud compute target-vpn-gateways create ${VPN_GW_NAME} \
    --network ${NETWORK} \
    --region ${REGION}

gcloud compute forwarding-rules create fr-${VPN_GW_NAME}-esp \
     --ip-protocol ESP \
     --address ${GW_IP_NAME} \
     --target-vpn-gateway ${VPN_GW_NAME} \
     --region ${REGION} \
     --project ${PROJECT}

gcloud compute forwarding-rules create fr-${VPN_GW_NAME}-udp500 \
    --ip-protocol UDP \
    --ports 500 \
    --address ${GW_IP_NAME} \
    --target-vpn-gateway ${VPN_GW_NAME} \
    --region ${REGION} \
    --project ${PROJECT}

gcloud compute forwarding-rules create fr-${VPN_GW_NAME}-udp4500 \
    --ip-protocol UDP \
    --ports 4500 \
    --address ${GW_IP_NAME} \
    --target-vpn-gateway ${VPN_GW_NAME} \
    --region ${REGION} \
    --project ${PROJECT}

gcloud compute routers create ${ROUTER_NAME} \
  --asn ${LOCAL_ASN} \
  --network ${NETWORK} \
  --region ${REGION} \
  --project ${PROJECT}

gcloud compute vpn-tunnels create ${TUNNEL_NAME} \
    --region ${REGION} \
    --peer-address ${PEER_IP} \
    --target-vpn-gateway ${VPN_GW_NAME} \
    --shared-secret ${SECRET} \
    --ike-version 2 \
    --router ${ROUTER_NAME}

gcloud compute routers add-interface ${ROUTER_NAME} \
    --interface-name ${INTERFACE_NAME} \
    --ip-address ${LOCAL_BGP_IP} \
    --mask-length 30 \
    --vpn-tunnel ${TUNNEL_NAME} \
    --region ${REGION} \
    --project ${PROJECT}

gcloud compute routers add-bgp-peer ${ROUTER_NAME} \
     --peer-name ${PEER_NAME} \
     --peer-asn ${PEER_ASN} \
     --peer-ip-address ${PEER_BGP_IP} \
     --interface ${INTERFACE_NAME} \
     --region ${REGION} \
     --project ${PROJECT}


# CLEAN UP
#===========================
gcloud compute target-pools remove-instances www-pool \
    --instances=legacy-www-0,legacy-www-1 \
    --instances-zone ${ZONE}

gcloud compute instances delete legacy-www-0 \
    --zone ${ZONE} \

gcloud compute instances delete legacy-www-1 \
    --zone ${ZONE} \

gcloud compute firewall-rules delete allow-all-legacy

gcloud compute networks delete ${NETWORK}
