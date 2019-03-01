#!/bin/bash

export PROJECT=host-project-39
export NETWORK_UNTRUST=nva-untrust
export NETWORK_PROD=nva-prod
export NETWORK_DEV=nva-dev
export SUBNET_UNTRUST=nva-untrust
export SUBNET_PROD=nva-prod
export SUBNET_DEV=nva-dev

gcloud beta compute routers create untrust-nat-eu-w1-cr1 \
    --network $NETWORK_UNTRUST \
    --region europe-west1

gcloud beta compute routers create prod-nat-eu-w1-cr1 \
    --network $NETWORK_PROD \
    --region europe-west1

gcloud beta compute routers nats create untrust-eu-w1-nat \
    --router-region europe-west1 \
    --router untrust-nat-eu-w1-cr1 \
    --nat-custom-subnet-ip-ranges $SUBNET_UNTRUST \
    --auto-allocate-nat-external-ips \
    --min-ports-per-vm=64 \
    --udp-idle-timeout=60 \
    --icmp-idle-timeout=60 \
    --tcp-established-idle-timeout=60 \
    --tcp-transitory-idle-timeout=60

gcloud beta compute routers nats create prod-eu-w1-nat \
    --router-region europe-west1 \
    --router prod-nat-eu-w1-cr1 \
    --nat-custom-subnet-ip-ranges $SUBNET_PROD \
    --auto-allocate-nat-external-ips \
    --min-ports-per-vm=64 \
    --udp-idle-timeout=60 \
    --icmp-idle-timeout=60 \
    --tcp-established-idle-timeout=60 \
    --tcp-transitory-idle-timeout=60

gcloud beta compute routers nats describe eu-w1-cr3-nat --router=eu-w1-cr3
