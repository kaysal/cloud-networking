#!/bin/bash

export PROJECT=mango-project-87
export NETWORK=vpc
export REGION=europe-west2
export CLOUD_ROUTER=eu-w2-cr1
export SUBNETS_EU_W2_CR1_NAT1=eu-w2-10-200-30

gcloud compute addresses create cloud-nat-ext-ip1 \
    --region $REGION

gcloud compute addresses create cloud-nat-ext-ip2 \
    --region $REGION

gcloud beta compute routers nats create eu-w2-cr1-nat1 \
    --router-region europe-west2 \
    --router $CLOUD_ROUTER \
    --nat-custom-subnet-ip-ranges $SUBNETS_EU_W2_CR1_NAT1 \
    --nat-external-ip-pool cloud-nat-ext-ip1,cloud-nat-ext-ip2\
    --min-ports-per-vm=64 \
    --udp-idle-timeout=60 \
    --icmp-idle-timeout=60 \
    --tcp-established-idle-timeout=60 \
    --tcp-transitory-idle-timeout=60
