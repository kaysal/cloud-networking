#!/bin/bash

export PROJECT=host-project-f0
export NETWORK=vpc

export GCE_EU_W1=\
apple-eu-w1-10-100-10

export GKE_EU_W1=\
gke-eu-w1-10-0-4,\
gke-eu-w1-10-0-4:svc-range,\
gke-eu-w1-10-0-4:pod-range

export GCE_EU_W2=\
apple-eu-w2-10-150-10

export GKE_EU_W2=\
gke-eu-w2-10-0-8,\
gke-eu-w2-10-0-8:svc-range,\
gke-eu-w2-10-0-8:pod-range

export GCE_US_E1=\
apple-us-e1-10-250-10

gcloud beta compute routers create nat-gce-eu-w1-cr1 \
    --network $NETWORK \
    --region europe-west1

gcloud beta compute routers create nat-gce-eu-w2-cr1 \
    --network $NETWORK \
    --region europe-west2

gcloud beta compute routers create nat-gce-us-e1-cr1 \
    --network $NETWORK \
    --region us-east1

gcloud beta compute routers create nat-gke-eu-w1-cr1 \
    --network $NETWORK \
    --region europe-west1

gcloud beta compute routers create nat-gke-eu-w2-cr1 \
    --network $NETWORK \
    --region europe-west2

gcloud beta compute routers nats create gce-eu-w1-nat1 \
    --router-region europe-west1 \
    --router nat-gce-eu-w1-cr1 \
    --nat-custom-subnet-ip-ranges $GCE_EU_W1 \
    --auto-allocate-nat-external-ips \
    --min-ports-per-vm=64 \
    --udp-idle-timeout=60 \
    --icmp-idle-timeout=60 \
    --tcp-established-idle-timeout=60 \
    --tcp-transitory-idle-timeout=60

gcloud beta compute routers nats create gke-eu-w1-nat1 \
    --router-region europe-west1 \
    --router nat-gke-eu-w1-cr1 \
    --nat-custom-subnet-ip-ranges $GKE_EU_W1 \
    --auto-allocate-nat-external-ips \
    --min-ports-per-vm=1024 \
    --udp-idle-timeout=60 \
    --icmp-idle-timeout=60 \
    --tcp-established-idle-timeout=60 \
    --tcp-transitory-idle-timeout=60

gcloud beta compute routers nats create gce-eu-w2-nat1 \
    --router-region europe-west2 \
    --router nat-gce-eu-w2-cr1 \
    --nat-custom-subnet-ip-ranges $GCE_EU_W2 \
    --auto-allocate-nat-external-ips \
    --min-ports-per-vm=64 \
    --udp-idle-timeout=60 \
    --icmp-idle-timeout=60 \
    --tcp-established-idle-timeout=60 \
    --tcp-transitory-idle-timeout=60

gcloud beta compute routers nats create gke-eu-w2-nat1 \
    --router-region europe-west2 \
    --router nat-gke-eu-w2-cr1 \
    --nat-custom-subnet-ip-ranges $GKE_EU_W2 \
    --auto-allocate-nat-external-ips \
    --min-ports-per-vm=1024 \
    --udp-idle-timeout=60 \
    --icmp-idle-timeout=60 \
    --tcp-established-idle-timeout=60 \
    --tcp-transitory-idle-timeout=60

gcloud beta compute routers nats create gce-us-e1-nat1 \
    --router-region us-east1 \
    --router nat-gce-us-e1-cr1 \
    --nat-custom-subnet-ip-ranges $GCE_US_E1 \
    --auto-allocate-nat-external-ips \
    --min-ports-per-vm=64 \
    --udp-idle-timeout=60 \
    --icmp-idle-timeout=60 \
    --tcp-established-idle-timeout=60 \
    --tcp-transitory-idle-timeout=60

gcloud beta compute routers nats describe eu-w1-cr3-nat1 --router=eu-w1-cr3
