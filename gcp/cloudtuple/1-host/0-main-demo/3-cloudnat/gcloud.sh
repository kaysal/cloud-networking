#!/bin/bash

export PROJECT=host-project-39
export NETWORK=vpc

export EU_W1=\
apple-eu-w1-10-100-10,\
gke-eu-w1-10-0-4,\
gke-eu-w1-10-0-4:svc-range,\
gke-eu-w1-10-0-4:pod-range

export EU_W2=\
apple-eu-w2-10-150-10,\
gke-eu-w2-10-0-8,\
gke-eu-w2-10-0-8:svc-range,\
gke-eu-w2-10-0-8:pod-range

export EU_W3=\
apple-eu-w3-10-200-10

gcloud beta compute routers create nat-eu-w1-cr1 \
    --network $NETWORK \
    --region europe-west1

gcloud beta compute routers create nat-eu-w2-cr1 \
    --network $NETWORK \
    --region europe-west2

gcloud beta compute routers create nat-eu-w3-cr1 \
    --network $NETWORK \
    --region europe-west3

gcloud beta compute routers nats create eu-w1-nat \
    --router-region europe-west1 \
    --router nat-eu-w1-cr1 \
    --nat-custom-subnet-ip-ranges $EU_W1 \
    --auto-allocate-nat-external-ips \
    --min-ports-per-vm=64 \
    --udp-idle-timeout=60 \
    --icmp-idle-timeout=60 \
    --tcp-established-idle-timeout=60 \
    --tcp-transitory-idle-timeout=60

gcloud beta compute routers nats create eu-w2-nat \
    --router-region europe-west2 \
    --router nat-eu-w2-cr1 \
    --nat-custom-subnet-ip-ranges $EU_W2 \
    --auto-allocate-nat-external-ips \
    --min-ports-per-vm=64 \
    --udp-idle-timeout=60 \
    --icmp-idle-timeout=60 \
    --tcp-established-idle-timeout=60 \
    --tcp-transitory-idle-timeout=60

gcloud beta compute routers nats create eu-w3-nat \
    --router-region europe-west3 \
    --router nat-eu-w3-cr1 \
    --nat-custom-subnet-ip-ranges $EU_W3 \
    --auto-allocate-nat-external-ips \
    --min-ports-per-vm=64 \
    --udp-idle-timeout=60 \
    --icmp-idle-timeout=60 \
    --tcp-established-idle-timeout=60 \
    --tcp-transitory-idle-timeout=60

gcloud beta compute routers nats describe eu-w1-cr3-nat --router=eu-w1-cr3
